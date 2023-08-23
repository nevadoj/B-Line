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
    @Published var nearbyStops = [Stops]()
    
    init(){
        self.getStops()
        for stop in self.stopsList{
            fetchStopAndEstimate(stopID: String(stop.StopNo))
        }
    }
    
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
    
    func addStop(stopID: String){
        let db = Firestore.firestore()
        let request = TLRequest(endpoint: .stops, otherBase: false)
        
        TLService.shared.execute(request.stopRequest(stopID), expecting: Stops.self){ result in
            switch result{
            case .success(let model):
                db.collection("stops").addDocument(data: ["StopNo":model.StopNo, "Name":model.Name, "BayNo":model.BayNo, "City":model.City, "OnStreet":model.OnStreet, "AtStreet":model.AtStreet, "Latitude":model.Latitude, "Longitude":model.Longitude, "WheelchairAccess":model.WheelchairAccess, "Distance":model.Distance, "Routes":model.Routes]){ error in
                    if error == nil{
                        self.getStops()
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
    
    
    // TODO: Just fetch a stopID string from DB instead of a Stops struct
    func getStops(){
        let db = Firestore.firestore()
        
        db.collection("stops").getDocuments{ snapshot, error in
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
    
    func getNearbyStops(lat: String, lon: String){
        let request = TLRequest(endpoint: .v1, otherBase: false)
        
        TLService.shared.execute(request.discoveryRequest(lat: lat, lon: lon), expecting: [Stops].self){ result in
            switch result{
            case .success(let model):
                DispatchQueue.main.async {
                    self.nearbyStops = model
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

