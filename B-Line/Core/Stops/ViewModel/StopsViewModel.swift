//
//  StopsViewModel.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-20.
//

import Foundation

class StopsViewModel: ObservableObject{
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
}

