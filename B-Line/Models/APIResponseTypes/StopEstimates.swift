//
//  StopEstimates.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-19.
//

import Foundation

struct StopEstimates: Codable {
    var RouteNo: String
    var RouteName: String
    var Direction: String
    var RouteMap: RouteMap
    var Schedules: [Schedule]
}

struct Schedule: Codable{
    var Pattern: String
    var Destination: String
    var ExpectedLeaveTime: String
    var ExpecteddCountdown: Int
    var ScheduleStatus: String // * scheduled, - delay, + ahead
    var CancelledTrip: Bool
    var CancelledStop: Bool
    var AddedTrip: Bool
    var AddedStop: Bool
    var LastUpdate: String // Last updated time of the trip
}

struct RouteMap: Codable{
    var Href: String
}

