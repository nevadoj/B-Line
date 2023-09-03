//
//  SavedStopsView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-09-02.
//

import SwiftUI

struct SavedStopsView: View {
    @State var addStop = false
    @EnvironmentObject var stopViewModel: StopsViewModel
    
    @State private var selectedStop: SavedStops?
    
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
                        ForEach(stopViewModel.savedStops.sorted(by: {$0.key < $1.key}), id: \.key){ key, stop in
                            ForEach(stop.Schedule, id: \.self){ bus in
                                StopViewCell(busNumber: bus.RouteNo, address: stop.BusStop.Name.capitalized, stopNumber: stop.BusStop.StopNo, arrivalTime: bus.Schedules.first?.ExpectedCountdown ?? -99)
                                    .padding(10)
                                    .onTapGesture {
                                        selectedStop = SavedStops(BusStop: stop.BusStop, Schedule: [bus])
                                    }
                            }
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("BPrimary"))
                    .sheet(item: $selectedStop){ selectedStop in
                        NavigationView{
                            DetailedStopView(stop: selectedStop)
                        }
                        .presentationDetents([.medium, .large])
                    }
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
                            .presentationDetents([.height(250)])
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

struct SavedStopsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedStopsView()
    }
}
