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
    @Published var savedStopsList = [SavedStops]()
    
    init(){
        print("Initializing stops viewmodel")
        self.getStops()
        for stop in self.stopsList{
            fetchStopAndEstimate(stopID: String(stop.StopNo))
        }
    }
    
    func sampleFetch(stopID: String){
        let request = TLRequest(endpoint: .stops)
        
        TLService.shared.execute(request.stopRequest(stopID), expecting: Stops.self){ result in
            switch result{
            case .success(let model):
                print(String(describing: model))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func addStop(stopID: String){
        // change DB to just store a string of stopID
        let db = Firestore.firestore()
        
        db.collection("bus_stops").addDocument(data: ["StopNo":stopID]){ error in
            if error == nil{
                self.getStops()
            }
            else{
                // Handle the error
                print(String(describing: error))
                return
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
        let request = TLRequest(endpoint: .stops)
        
        TLService.shared.execute(request.stopRequest(stopID), expecting: Stops.self){ result in
            switch result{
            case .success(let model):
                TLService.shared.execute(request.estimateRequest(stopID), expecting: [StopEstimates].self){ estimateResult in
                    switch estimateResult{
                    case .success(let estimateModel):
                        DispatchQueue.main.async {
                            self.savedStopsList.append(SavedStops(BusStop: model, Schedule: estimateModel))
                            print("Added Stop \(model.Name)")
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
        savedStopsList.removeAll()
        for stop in self.stopsList{
            fetchStopAndEstimate(stopID: String(stop.StopNo))
        }
    }
}

