//
//  Routes.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-19.
//

import Foundation

struct Pattern: Codable{
    var PatternNo: String
    var Destination: String
    var RouteMap: RouteMap
    var Direction: String
}

struct Routes{
    var RouteNo: String
    var Name: String
    var OperatingCompany: String
    var Patterns: [Pattern]
}
