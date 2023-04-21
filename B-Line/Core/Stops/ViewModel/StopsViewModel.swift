//
//  StopsViewModel.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-20.
//

import Foundation
import Firebase

class StopsViewModel: ObservableObject{
    
    // create Stop list variable and let the view access it
    @Published var list = [Stops]()
    
    // fetch saved routes from Firebase -- fetch saved routes that user has from Firebase
    
//    func sampleFetch() {
//        TLService.shared.execute(.stopsRequest, expecting: Stops.self) { result in
//            switch result {
//            case .success(let model):
//                print(model.Name)
//
//            case .failure(let error):
//                print(String(describing: error))
//            }
//        }
//    }
    
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
        // this request should get the stop information, and then store into database
        // don't want to keep requesting the .stops endpoint when we load the page
    }
    
    func addStop(stopID: String){
        
    }
    
    
    func getStops(){
        let db = Firestore.firestore()
        
        db.collection("stops").getDocuments{ snapshot, error in
            if(error == nil){
                if let snapshot = snapshot {
                    self.list = snapshot.documents.map{ d in
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

