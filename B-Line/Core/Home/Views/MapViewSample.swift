//
//  MapViewSample.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-23.
//

import SwiftUI
import MapKit

struct MapViewSample: View {
    @StateObject private var locationManager = LocationManager()
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    var region: Binding<MKCoordinateRegion>? {
        guard let location = locationManager.location else {
            return MKCoordinateRegion.defaultRegion().getBinding()
        }
        
        let region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        return region.getBinding()
    }
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: region!, showsUserLocation: true)
                .ignoresSafeArea()
        }
    }
}

struct MapViewSample_Previews: PreviewProvider {
    static var previews: some View {
        MapViewSample()
    }
}
