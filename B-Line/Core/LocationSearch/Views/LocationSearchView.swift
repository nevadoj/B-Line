//
//  LocationSearchView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-11.
//

import SwiftUI

struct LocationSearchView: View {
    
    @Binding var showSearchMenu: Bool
    @Binding var defaultLocation: Bool
    @Binding var showNavBar: Bool
    
    @EnvironmentObject var stopViewModel: StopsViewModel
    @EnvironmentObject var userLocationViewModel: LocationViewModel
    
    var body: some View {
        VStack {
            Button{
                showSearchMenu.toggle()
                showNavBar.toggle()
            } label: {
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8)){
                    PrimaryButton(imageName: showSearchMenu ? "xmark" : "magnifyingglass")
                }
            }
            .padding(.vertical)
            
            if(!defaultLocation){
                Button{
                    defaultLocation.toggle()
                    stopViewModel.getNearbyStopsTask(lat: String(format: "%.6f", userLocationViewModel.region.center
                        .latitude), lon: String(format: "%.6f", userLocationViewModel.region.center
                        .longitude))
                } label: {
                    PrimaryButton(imageName: "location.fill")
                }
                                
            }
        }
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(showSearchMenu: .constant(true), defaultLocation: .constant(false), showNavBar: .constant(true))
    }
}
