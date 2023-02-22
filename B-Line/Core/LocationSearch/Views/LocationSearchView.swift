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
    
    var body: some View {
        Button{
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8)){
                showSearchMenu.toggle()                
            }
        } label: {
            PrimaryButton(imageName: showSearchMenu ? "xmark" : "magnifyingglass")
        }
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(showSearchMenu: .constant(true))
    }
}
