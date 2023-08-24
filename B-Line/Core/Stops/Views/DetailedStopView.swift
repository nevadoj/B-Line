//
//  DetailedStopView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-08-23.
//

import SwiftUI

struct DetailedStopView: View {
    
//    var stop: Stops
//    var bus: StopEstimates
    var stop: SavedStops
    
    var body: some View {
        ZStack{
            Color("BPrimary").ignoresSafeArea()
            ScrollView{
                VStack{
                    Text(stop.BusStop.Name.capitalized)
                }
            }
        }
    }
}

struct DetailedStopView_Previews: PreviewProvider {
    static var previews: some View {
        let previewStop = SavedStops(BusStop: Stops(StopNo: 61035, Name: "SURREY CENTRAL STN BAY 12", BayNo: "12", City: "SURREY", OnStreet: "SURREY CENTRAL STN", AtStreet: "BAY 12", Latitude: 49.189699, Longitude: -122.847774, WheelchairAccess: 1, Distance: -1.0, Routes: "502"), Schedule: [StopEstimates(RouteNo: "502", RouteName: "LANGLEY CENTRE/SURREY CENTRAL STN", Direction: "EAST", RouteMap: RouteMap(Href: "https://nb.translink.ca/geodata/502.kmz"), Schedules: [Schedule(Pattern: "EB7", Destination: "LANGLEY CTR", ExpectedLeaveTime: "6:27pm 2023-08-23", ExpectedCountdown: -3, ScheduleStatus: "-", CancelledTrip: false, CancelledStop: false, AddedTrip: false, AddedStop: false, LastUpdate: "05:37:34 pm"), Schedule(Pattern: "EB7", Destination: "LANGLEY CTR", ExpectedLeaveTime: "6:37pm 2023-08-23", ExpectedCountdown: 7, ScheduleStatus: "*", CancelledTrip: false, CancelledStop: false, AddedTrip: false, AddedStop: true, LastUpdate: "05:37:04 pm"), Schedule(Pattern: "EB7", Destination: "LANGLEY CTR", ExpectedLeaveTime: "6:49pm 2023-08-23", ExpectedCountdown: 19, ScheduleStatus: "*", CancelledTrip: false, CancelledStop: false, AddedTrip: false, AddedStop: true, LastUpdate: "05:49:01 pm"), Schedule(Pattern: "EB7", Destination: "LANGLEY CTR", ExpectedLeaveTime: "7:01pm 2023-08-23", ExpectedCountdown: 31, ScheduleStatus: " ", CancelledTrip: false, CancelledStop: false, AddedTrip: false, AddedStop: false, LastUpdate: "06:29:02 pm"), Schedule(Pattern: "EB7", Destination: "LANGLEY CTR", ExpectedLeaveTime: "7:13pm 2023-08-23", ExpectedCountdown: 43, ScheduleStatus: " ", CancelledTrip: false, CancelledStop: false, AddedTrip: false, AddedStop: true, LastUpdate: "06:13:14 pm"), Schedule(Pattern: "EB7", Destination: "LANGLEY CTR", ExpectedLeaveTime: "7:25pm 2023-08-23", ExpectedCountdown: 55, ScheduleStatus: " ", CancelledTrip: false, CancelledStop: false, AddedTrip: false, AddedStop: true, LastUpdate: "06:25:04 pm")])])
        NavigationView{
            DetailedStopView(stop: previewStop)
        }
    }
}
