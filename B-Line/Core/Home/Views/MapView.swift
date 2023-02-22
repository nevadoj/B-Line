//
//  MapView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-14.
//

import SwiftUI

struct MapView: View {
    
    @State private var showSearchMenu = false
    
    var body: some View {
        ZStack(alignment: .top){
            if(!showSearchMenu){
                MapViewRepresentable()
                    .ignoresSafeArea()
            }
            else{
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8)){
                    LocationSearchMenuView()                    
                }
            }
            
            HStack {
                Spacer()
                LocationSearchView(showSearchMenu: $showSearchMenu)
                    .padding(25)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
