//
//  SavedStops.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-04-25.
//

import Foundation

struct SavedStops: Codable, Hashable{
    var BusStop: Stops
    var Schedule: [StopEstimates]
}
