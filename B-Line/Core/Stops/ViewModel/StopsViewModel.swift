//
//  StopsViewModel.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-20.
//

// Make our own struct that holds a Stops & StopEstimates and then just make an array using that new struct 

import Foundation
import Firebase

class StopsViewModel: ObservableObject{
    
    // create Stop list variable and let the view access it
    @Published var stopsList = [Stops](){
        didSet{
            for stop in self.stopsList{
                fetchStopAndEstimate(stopID: String(stop.StopNo))
            }
        }
    }
    @Published var savedStops: [Int : SavedStops] = [:]
    @Published var discoverStopEstimates = [StopEstimates]()
    @Published var nearbyStops = [SavedStops]()
    
    let BASE_URL = "https://api.translink.ca/rttiapi/v1"
    let BASE_URL2 = "https://api.translink.ca/rttiapi"
//    func sampleFetch(){
//        let request = TLRequest(endpoint: .v1, otherBase: false)
//
//        TLService.shared.execute(request.discoveryRequest(), expecting: [Stops].self){ result in
//            switch result{
//            case .success(let model):
//                print(String(describing: model))
//            case .failure(let error):
//                print(String(describing: error))
//            }
//        }
//    }
    
    // TODO: Update with URLSession async & make main actor
    func addStop(stopID: String){
        let db = Firestore.firestore()
        let request = TLRequest(endpoint: .stops, otherBase: false)
        
        var userID: String = ""
        do{
            let authData = try AuthenticationManager.shared.getAuthenticatedUser()
            userID = authData.uid
        }
        catch{
            print("Error getting user \(error)")
        }
        
        TLService.shared.execute(request.stopRequest(stopID), expecting: Stops.self){ result in
            switch result{
            case .success(let model):
                db.collection("users").document(userID).collection("stops").addDocument(data: ["StopNo":model.StopNo, "Name":model.Name, "BayNo":model.BayNo, "City":model.City, "OnStreet":model.OnStreet, "AtStreet":model.AtStreet, "Latitude":model.Latitude, "Longitude":model.Longitude, "WheelchairAccess":model.WheelchairAccess, "Distance":model.Distance, "Routes":model.Routes]){ error in
                    if error == nil{
                        self.getStops(addNew: true)
                    }
                    else{
                        print(String(describing: error))
                        return
                    }
                }
            case .failure(let error):
                print(String(describing: error))
            }
            
        }
    }
    
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
    
    // TODO: Update with URLSession async & make main actor
    func fetchStopAndEstimate(stopID: String){
        let request = TLRequest(endpoint: .stops, otherBase: false)
        
        TLService.shared.execute(request.stopRequest(stopID), expecting: Stops.self){ result in
            switch result{
            case .success(let model):
                TLService.shared.execute(request.estimateRequest(stopID), expecting: [StopEstimates].self){ estimateResult in
                    switch estimateResult{
                    case .success(let estimateModel):
                        DispatchQueue.main.async {
                            let saved = self.savedStops.contains{ key, value in
                                return key == model.StopNo
                            }
                            if saved{
                                // just update estimates
                                self.savedStops[model.StopNo]?.Schedule = estimateModel
                                print("Updated Estimates for \(model.StopNo)")
                            }
                            else{
                                // add to savedStops
                                self.savedStops[model.StopNo] = SavedStops(BusStop: model, Schedule: estimateModel)
                                print("Added Stop \(model.Name)")
                            }
                        }
                    case .failure(let estimateError):
                        print(String(describing: estimateError))
                    }
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func getStopEstimates(){
        for stop in self.stopsList{
            fetchStopAndEstimate(stopID: String(stop.StopNo))
        }
    }
    
    
    // TODO: Update with URLSession async & make main actor
    func getNearbyStops(lat: String, lon: String){
        let request = TLRequest(endpoint: .v1, otherBase: false)
        self.nearbyStops.removeAll()
        
        TLService.shared.execute(request.discoveryRequest(lat: lat, lon: lon), expecting: [Stops].self){ result in
            switch result{
            case .success(let model):
                let estimateRequest = TLRequest(endpoint: .stops, otherBase: false)
                for stop in model{
                    TLService.shared.execute(estimateRequest.estimateRequest(String(stop.StopNo)), expecting: [StopEstimates].self){ estimateResult in
                        switch estimateResult{
                        case .success(let estimateModel):
                            DispatchQueue.main.async {
                                self.nearbyStops.append(SavedStops(BusStop: stop, Schedule: estimateModel))
                            }
                        case .failure(let estimateError):
                            print(String(describing: estimateError))
                        }
                    }
                }
            case .failure(let error):
                print("Failed to get nearby stops:" + String(describing: error))
            }
        }
    }
    
    
    // TODO: Update with URLSession async & make main actor
    func fetchDiscoverEstimate(stopID: String){
        let request = TLRequest(endpoint: .stops, otherBase: false)
        
        TLService.shared.execute(request.estimateRequest(stopID), expecting: [StopEstimates].self){ estimateResult in
            switch estimateResult{
            case .success(let estimateModel):
                DispatchQueue.main.async {
                        self.discoverStopEstimates.removeAll()
                        self.discoverStopEstimates = estimateModel
                    }
            case .failure(let estimateError):
                print(String(describing: estimateError))
            }
        }
    }
}
