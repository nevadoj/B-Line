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
                        ForEach(stopViewModel.savedStops.sorted(by: {$0.key < $1.key}), id: \.key){ key, sched in
                            ForEach(sched.Schedule, id: \.self){ bus in
                                // Get first entry from Schedules and display on view cell
                                // Pass in bus into sheet view for detailed view
                                
                                StopViewCell(busNumber: bus.RouteNo, address: sched.BusStop.Name.capitalized, stopNumber: sched.BusStop.StopNo, arrivalTime: bus.Schedules.first?.ExpectedCountdown ?? -99)
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
//                            stopViewModel.sampleFetch()
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

struct StopsView_Previews: PreviewProvider {
    static var previews: some View {
        StopsView()
    }
}
