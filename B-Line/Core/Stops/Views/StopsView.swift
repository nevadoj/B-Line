//
//  StopsView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-14.
//

import SwiftUI

struct StopsView: View {
    
    @State var addStop = false
    @EnvironmentObject var stopViewModel: StopsViewModel
    
    init(){
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = UIColor.clear
        appearance.backgroundColor = UIColor(Color("BPrimary"))
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                ZStack{
                    VStack(alignment: .leading){
                        ForEach(stopViewModel.savedStopsList, id: \.self){ stop in
                            ForEach(stop.Schedule, id: \.self){ bus in
                                // Get first entry from Schedules and display on view cell
                                // Pass in bus into sheet view for detailed view
                                
                                // Abstract this to the viewModel
                                let arrivalString = bus.Schedules.first?.ExpectedLeaveTime
                                let arrivalDate = arrivalString?.dateFromString(inputStr: arrivalString ?? "10:34p.m 2022-04-26")
                                
                                let arrivalTimestamp = Int((arrivalDate?.timeIntervalSinceNow ?? 0) / 60) // handle if negative?
                                StopViewCell(busNumber: bus.RouteNo, address: stop.BusStop.Name.capitalized, stopNumber: stop.BusStop.StopNo, arrivalTime: arrivalTimestamp)
                                    .padding(10)
                            }
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("BPrimary"))
                }
                .navigationTitle("Stops")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button{
                            addStop.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                        .sheet(isPresented: $addStop){
                            NavigationView{
                                AddStopView()
                                    .navigationTitle("Add Stop")
                            }
                            .presentationDetents([.medium])
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color("BPrimary"))
        }
        .onAppear{
            stopViewModel.getStopEstimates()
        }
    }
}

struct StopsView_Previews: PreviewProvider {
    static var previews: some View {
        StopsView()
    }
}
