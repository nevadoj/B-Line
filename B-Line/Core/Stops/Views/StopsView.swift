//
//  StopsView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-14.
//

import SwiftUI

struct StopsView: View {
    
    @State var addStop = false
    @StateObject private var viewModel = StopsViewModel()
    
    init(){
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
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
                Text("Hello World!")
                    .foregroundColor(.white)
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
//            viewModel.sampleFetch(stopID: "58946")
            // call API to update bus times
        }
    }
}

struct StopsView_Previews: PreviewProvider {
    static var previews: some View {
        StopsView()
    }
}
