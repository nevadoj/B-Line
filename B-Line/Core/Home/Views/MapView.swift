//
//  MapView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-14.
//

import SwiftUI

struct MapView: View {
    
    @Binding var showSearchMenu: Bool
    @Binding var defaultLocation: Bool
    @Binding var showNavBar: Bool
    
    var body: some View {
        ZStack(alignment: .top){
            if(!showSearchMenu){
                MapViewMain(defaultLocation: $defaultLocation)
                    .ignoresSafeArea()
            }
            else{
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8)){
                    LocationSearchMenuView(showSearchMenu: $showSearchMenu, defaultLocation: $defaultLocation, showNavBar: $showNavBar)
                }
            }
            
            HStack {
                Spacer()
                LocationSearchView(showSearchMenu: $showSearchMenu, defaultLocation: $defaultLocation, showNavBar: $showNavBar)
                    .padding(25)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(showSearchMenu: .constant(false), defaultLocation: .constant(true), showNavBar: .constant(true))
    }
}
