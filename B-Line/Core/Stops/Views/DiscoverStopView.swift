//
//  DiscoverStopView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-08-28.
//

import SwiftUI

struct DiscoverStopView: View {
    
    @EnvironmentObject var stopViewModel: StopsViewModel
    var stop: Stops
    
    let defaultEstimates = [StopEstimates(RouteNo: "502", RouteName: "ROUTENAME", Direction: "EAST", RouteMap: RouteMap(Href: "https://nb.translink.ca/geodata/502.kmz"), Schedules: [Schedule(Pattern: "EB7", Destination: "LANGLEY CTR", ExpectedLeaveTime: "6:27pm 2023-08-23", ExpectedCountdown: -3, ScheduleStatus: "-", CancelledTrip: false, CancelledStop: false, AddedTrip: false, AddedStop: false, LastUpdate: "05:37:34 pm")]), StopEstimates(RouteNo: "375", RouteName: "WHITE ROCK/WHITE ROCK STH/GUILDFORD", Direction: "SOUTH", RouteMap: B_Line.RouteMap(Href: "https://nb.translink.ca/geodata/375.kmz"), Schedules: [Schedule(Pattern: "S1", Destination: "WHITE ROCK S.", ExpectedLeaveTime: "8:55pm 2023-08-28", ExpectedCountdown: 19, ScheduleStatus: "*", CancelledTrip: false, CancelledStop: false, AddedTrip: false, AddedStop: false, LastUpdate: "07:53:06 pm"), Schedule(Pattern: "S1", Destination: "WHITE ROCK S.", ExpectedLeaveTime: "9:57pm 2023-08-28", ExpectedCountdown: 81, ScheduleStatus: "*", CancelledTrip: false, CancelledStop: false, AddedTrip: false, AddedStop: false, LastUpdate: "10:05:03 pm")])]
    
    var body: some View {
        ZStack{
            Color("BPrimary").ignoresSafeArea()
            ScrollView{
                VStack(alignment: .leading){
                    // add Picker() for buses
                    // change schedules when changing
                }
            }
        }
        .onAppear{
//            stopViewModel.fetchDiscoverEstimate(stopID: String(stop.StopNo))
        }
    }
}

struct DiscoverStopView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverStopView(stop: Stops(StopNo: 55957, Name: "NB 150 ST FS 102A AVE", BayNo: "N", City: "SURREY", OnStreet: "150 ST", AtStreet: "102A AVE", Latitude: 49.189261, Longitude: -122.806311, WheelchairAccess: 1, Distance: 51.0, Routes: "341"))
    }
}
