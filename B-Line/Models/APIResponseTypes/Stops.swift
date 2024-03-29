//
//  Stops.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-19.
//

import Foundation

struct Stops: Codable, Hashable, Identifiable{
    var StopNo: Int
    var Name: String
    var BayNo: String
    var City: String
    var OnStreet: String
    var AtStreet: String
    var Latitude: Double
    var Longitude: Double
    var WheelchairAccess: Int
    var Distance: Double
    var Routes: String
    
    var id: Int{
        StopNo
    }
}
