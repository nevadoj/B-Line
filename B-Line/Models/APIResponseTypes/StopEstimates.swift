//
//  StopEstimates.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-19.
//

import Foundation

struct StopEstimates: Codable, Hashable, Equatable, Identifiable{
    static func == (lhs: StopEstimates, rhs: StopEstimates) -> Bool {
        return lhs.RouteName == rhs.RouteName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(RouteName)
    }
    var RouteNo: String
    var RouteName: String
    var Direction: String
    var RouteMap: RouteMap
    var Schedules: [Schedule]
    
    var id: String{
        RouteNo
    }
}

struct Schedule: Codable, Hashable, Identifiable{
    var Pattern: String
    var Destination: String
    var ExpectedLeaveTime: String
    var ExpectedCountdown: Int
    var ScheduleStatus: String // * scheduled, - delay, + ahead
    var CancelledTrip: Bool
    var CancelledStop: Bool
    var AddedTrip: Bool
    var AddedStop: Bool
    var LastUpdate: String // Last updated time of the trip
    
    var id: String{
        ExpectedLeaveTime
    }
}

struct RouteMap: Codable{
    var Href: String
}

