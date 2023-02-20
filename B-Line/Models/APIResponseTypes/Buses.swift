//
//  Buses.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-19.
//

import Foundation

struct Bus: Codable {
    var VehicleNo: String
    var RouteNo: String
    var Direction: String
    var Destination: String
    var Pattern: String
    var Latitude: Double
    var Longitude: Double
    var RecordedTime: String
    var RouteMap: RouteMap
}

struct Buses: Codable {
    var Buses: [Bus]
}
