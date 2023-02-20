//
//  StopsModel.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-19.
//

import Foundation

struct Stop: Codable{
    var StopNo: Int
    var Name: String
    var BayNo: Int
    var City: String
    var OnStreet: String
    var AtStreet: String
    var Latitude: Double
    var Longitude: Double
    var WheelchairAccess: Int
    var Distance: Double
    var Routes: String
}
