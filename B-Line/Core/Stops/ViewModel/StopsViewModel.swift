//
//  StopsViewModel.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-20.
//

import Foundation
import Firebase

class StopsViewModel: ObservableObject{
    
    @Published var stopsList = [Stops](){
        didSet{
            getStopEstimates()
        }
    }
    @Published var savedStops: [Int : SavedStops] = [:]
    @Published var discoverStopEstimates = [StopEstimates]()
    @Published var nearbyStops = [SavedStops]()
    
    let BASE_URL = "https://api.translink.ca/rttiapi/v1"
    
    @MainActor
    func addStopAsync(stopID: String) async throws{
        let db = Firestore.firestore()
        
        var userID: String = ""
        do{
            let authData = try AuthenticationManager.shared.getAuthenticatedUser()
            userID = authData.uid
            
            guard let url = URL(string: "\(BASE_URL)/stops/\(stopID)?apikey=\(apiKey)") else { throw StopError.invalidURL }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw StopError.serverError}
            guard let stopData = try? JSONDecoder().decode(Stops.self, from: data) else { throw StopError.invalidData }
            
            db.collection("users").document(userID).collection("stops").addDocument(data: ["StopNo":stopData.StopNo, "Name":stopData.Name, "BayNo":stopData.BayNo, "City":stopData.City, "OnStreet":stopData.OnStreet, "AtStreet":stopData.AtStreet, "Latitude":stopData.Latitude, "Longitude":stopData.Longitude, "WheelchairAccess":stopData.WheelchairAccess, "Distance":stopData.Distance, "Routes":stopData.Routes]){ error in
                if error == nil{
                    self.getStops(addNew: true)
                }
                else{
                    print(String(describing: error))
                    return
                }
            }
        }
        catch{
            print("Error: \(error)")
        }
    }
    
    func addStopTask(stopID: String){
        Task{
            try await addStopAsync(stopID: stopID)
        }
    }
    
    
    func getStops(addNew: Bool){
        if(stopsList.isEmpty || addNew){
            let db = Firestore.firestore()
            
            var userID: String = ""
            do{
                let authData = try AuthenticationManager.shared.getAuthenticatedUser()
                userID = authData.uid
            }
            catch{
                print("Error getting user \(error)")
            }
            
            db.collection("users").document(userID).collection("stops").getDocuments{ snapshot, error in
                if(error == nil){
                    if let snapshot = snapshot {
                        self.stopsList = snapshot.documents.map{ d in
                            // return Stop object
                            return Stops(StopNo: d["StopNo"] as? Int ?? 0,
                                         Name: d["Name"] as? String ?? "Street",
                                         BayNo: d["BayNo"] as? String ?? "N/A",
                                         City: d["City"] as? String ?? "City",
                                         OnStreet: d["OnStreet"] as? String ?? "OnStreet",
                                         AtStreet: d["AtStreet"] as? String ?? "AtStreet",
                                         Latitude: d["Latitude"] as? Double ?? 0.0,
                                         Longitude: d["Longitude"] as? Double ?? 0.0,
                                         WheelchairAccess: d["WheelchairAccess"] as? Int ?? 0,
                                         Distance: d["Distance"] as? Double ?? 0.0,
                                         Routes: d["Routes"] as? String ?? "Routes")
                        }
                    }
                }
                else{
                    // handle error
                    print(String(describing: error))
                    return
                }
            }
        }
    }
    
    // TODO: RemoveStops -- on signout of account, remove saved stops in list -> incase another user signs in

    @MainActor
    func fetchStopAndEstimateAsync(stopID: String) async throws{
        do{
            guard let stopUrl = URL(string: "\(BASE_URL)/stops/\(stopID)?apikey=\(apiKey)") else {
                throw StopError.invalidURL
            }
            
            guard let estimateUrl = URL(string: "\(BASE_URL)/stops/\(stopID)/estimates?apikey=\(apiKey)") else{
                throw StopError.invalidURL
            }
            
            let stopRequest = makeURLRequest(url: stopUrl)
            let estimateRequest = makeURLRequest(url: estimateUrl)
            
            // API Call for stop
            let (stopData, stopResponse) = try await URLSession.shared.data(for: stopRequest)
            guard (stopResponse as? HTTPURLResponse)?.statusCode == 200 else {
                throw StopError.serverError
            }
            guard let stop = try? JSONDecoder().decode(Stops.self, from: stopData) else { throw StopError.invalidData}
            
            // API Call for stop estimate
            let (estimateData, estimateResponse) = try await URLSession.shared.data(for: estimateRequest)
            guard (estimateResponse as? HTTPURLResponse)?.statusCode == 200 else{
                throw StopError.serverError
            }
            guard let estimate = try? JSONDecoder().decode([StopEstimates].self, from: estimateData) else { throw EstimateError.invalidData }
            
            let saved = self.savedStops.contains{ key, value in
                return key == stop.StopNo
            }
            if saved{
                // Just update estimates
                self.savedStops[stop.StopNo]?.Schedule = estimate
                print("Updated Estimates for \(stop.StopNo)")
            }
            else{
                // Add to savedStops
                self.savedStops[stop.StopNo] = SavedStops(BusStop: stop, Schedule: estimate)
                print("Added Stop \(stop.Name)")
            }
        }
        catch{
            print("Error: \(error)")
        }
    }
    
    func getStopEstimates(){
        Task{
            for stop in self.stopsList{
                try await fetchStopAndEstimateAsync(stopID: String(stop.StopNo))
            }
        }
    }
    
    @MainActor
    func getNearbyStopsAsync(lat: String, lon: String) async throws {
        self.nearbyStops.removeAll()
        
        do{
            guard let stopUrl = URL(string: "\(BASE_URL)/stops?apikey=\(apiKey)&lat=\(lat)&long=\(lon)") else { throw StopError.invalidURL }
            
            let stopRequest = makeURLRequest(url: stopUrl)
            
            let (stopData, stopResponse) = try await URLSession.shared.data(for: stopRequest)
            guard (stopResponse as? HTTPURLResponse)?.statusCode == 200 else {
                throw StopError.serverError
            }
            guard let stops = try? JSONDecoder().decode([Stops].self, from: stopData) else { throw StopError.invalidData }
            
            for stop in stops{
                guard let estimateUrl = URL(string: "\(BASE_URL)/stops/\(stop.StopNo)/estimates?apikey=\(apiKey)") else{
                    throw StopError.invalidURL
                }
                let estimateRequest = makeURLRequest(url: estimateUrl)
                
                let (estimateData, estimateResponse) = try await URLSession.shared.data(for: estimateRequest)
                guard (estimateResponse as? HTTPURLResponse)?.statusCode == 200 else{
                    throw EstimateError.serverError
                }
                guard let estimate = try? JSONDecoder().decode([StopEstimates].self, from: estimateData) else { throw EstimateError.invalidData }
                
                self.nearbyStops.append(SavedStops(BusStop: stop, Schedule: estimate))
            }
        }
        catch{
            print("Error: \(error.localizedDescription)")
        }
    }

    func getNearbyStopsTask(lat: String, lon: String){
        Task(priority: .high){
            try await getNearbyStopsAsync(lat: lat, lon: lon)
        }
    }
}

extension StopsViewModel{
    func makeURLRequest(url: URL) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
}
