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
        viewModel.getStopEstimates()
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
                // WE JUST WANT TO WORK WITH estimatesList instead of stopsList directly for display purposes
                VStack(alignment: .leading){
                    // Heading for specific stop number
                    ForEach(viewModel.stopsList, id: \.self){ stop in
                        let routes = stop.Routes.components(separatedBy: ", ")
                        ForEach(routes, id: \.self){ bus in
                            StopViewCell(busNumber: bus, address: stop.Name, stopNumber: stop.StopNo)
                                .padding(10)
                                .onTapGesture {
                                    viewModel.checkEstimatesList()
                                }
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
                        viewModel.getStopEstimates()
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
//            viewModel.sampleFetch(stopID: "58946")
            // call API to update bus times -- call viewModel function which will call translink API
            
            // For each viewmodel.List (saved bus routes) query the API 
//            viewModel.sampleEstimates(stopID: "58946")
        }
    }
}

struct StopsView_Previews: PreviewProvider {
    static var previews: some View {
        StopsView()
    }
}
