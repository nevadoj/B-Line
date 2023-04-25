//
//  StopsView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-14.
//

import SwiftUI

struct StopsView: View {
    
    @State var addStop = false
    @ObservedObject private var viewModel = StopsViewModel()
    
    init(){
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        
        viewModel.getStops()
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                Color("BPrimary").ignoresSafeArea()
                
                /*
                 TODO: Call firebase to load saved Bus Stops in database
                 TODO: Display bus stops with StopViewCell
                 
                 for each bus stop in database: display with StopViewCell
                 */
                
                // Need a scrollview for the stop cells
                VStack(alignment: .leading){
                    ForEach(viewModel.savedStopsList, id: \.self){ stop in
                        ForEach(stop.Schedule, id: \.self){ bus in
                            StopViewCell(busNumber: bus.RouteNo, address: stop.BusStop.Name, stopNumber: stop.BusStop.StopNo)
                                .padding(10)
                        }
                    }
                    Spacer()
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
                        .presentationDetents([.medium])
                    }
                }
            }
        }
        .onAppear(){
            
        }
    }
}

struct StopsView_Previews: PreviewProvider {
    static var previews: some View {
        StopsView()
    }
}
