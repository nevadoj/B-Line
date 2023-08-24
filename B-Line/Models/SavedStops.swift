//
//  SavedStops.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-04-25.
//

import Foundation

struct SavedStops: Codable, Hashable, Identifiable{
    var BusStop: Stops
    var Schedule: [StopEstimates]
    
    var id: Int{
        BusStop.id
    }
}
