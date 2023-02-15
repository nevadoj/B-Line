//
//  MapView.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-14.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        ZStack(alignment: .top){
            MapViewRepresentable()
                .ignoresSafeArea()
            
            LocationSearchView()
                .padding()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
