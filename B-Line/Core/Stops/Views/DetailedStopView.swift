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
    
    let defaultEstimate = StopEstimates(RouteNo: "Bus#", RouteName: "ROUTENAME", Direction: "EAST", RouteMap: RouteMap(Href: "https://nb.translink.ca/geodata/502.kmz"), Schedules: [Schedule(Pattern: "EB7", Destination: "LANGLEY CTR", ExpectedLeaveTime: "6:27pm 2023-08-23", ExpectedCountdown: -3, ScheduleStatus: "-", CancelledTrip: false, CancelledStop: false, AddedTrip: false, AddedStop: false, LastUpdate: "05:37:34 pm")])
    
    var body: some View {
        ZStack{
            Color("BPrimary").ignoresSafeArea()
            ScrollView{
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            // Bus #
                            Text(stop.Schedule.first?.RouteNo ?? defaultEstimate.RouteNo)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.horizontal, 30)
                                .padding(.top, 45)
                                .padding(.bottom, 1)
                            
                            // Destination Location
                            LocationText(imageName: "mappin.and.ellipse", locationName: stop.Schedule.first?.Schedules.first?.Destination.capitalized ?? "Destination", color: .white, font: .title2)
                                .padding(.horizontal, 30)
                            
                            // Bus Stop Location
                            LocationText(imageName: "arrow.turn.down.right", locationName: stop.BusStop.Name.capitalized, color: Color(hex: "DCDCDC"), font: .title3)
                                .padding(.horizontal, 30)
                    
                            // ETA
                            let arrivalTime = Int(stop.Schedule.first?.Schedules.first?.ExpectedCountdown ?? -99)
                            LocationText(imageName: "bus.fill", locationName: "\(arrivalTime) minutes", color: .white, font: .title2)
                                .frame(height: UIScreen.main.bounds.height / 18)
                                .frame(maxWidth: UIScreen.main.bounds.width / 2)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color("BSecondary"))
                                        .shadow(color: Color("BSecondary").opacity(0.5), radius:6, x:4, y:5)
                                )
                                .padding(.horizontal, 30)
                                .padding(.vertical)
                            
                            // Schedule
                            Text("Schedules")
                                .foregroundColor(.white)
                                .padding(.horizontal, 30)
                                .padding(.vertical)
                                .font(.title2)
                                .fontWeight(.semibold)
                            ForEach(stop.Schedule.first?.Schedules ?? defaultEstimate.Schedules){ schedule in
                                HStack{
                                    let busNumber = stop.Schedule.first?.RouteNo
                                    let dest = schedule.Destination
                                    LocationText(imageName: "clock", locationName: "\(busNumber ?? "N/A") \(dest.capitalized)", color: Color(hex: "DCDCDC"), font: .body)
                                        .padding(.horizontal, 30)
                                    Spacer()
                                    Text("".timeFromString(inputStr: schedule.ExpectedLeaveTime))
                                        .padding(.horizontal, 30)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(hex: "DCDCDC"))
                                }
                                Divider()
                                    .background(.white)
                                    .padding(.horizontal, 30)
                            }
                        }
                        Spacer()
                    }
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
