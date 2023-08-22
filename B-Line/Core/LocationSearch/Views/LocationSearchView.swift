//
//  LocationSearchView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-11.
//

import SwiftUI

struct LocationSearchView: View {
    
    @StateObject var viewModel = LocationSearchViewModel()
    @Binding var showSearchMenu: Bool
    @Binding var defaultLocation: Bool
    @Binding var showNavBar: Bool
    
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
