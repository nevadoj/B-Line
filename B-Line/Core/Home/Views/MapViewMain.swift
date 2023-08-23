//
//  MapViewMain.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-23.
//

import SwiftUI
import MapKit

struct MapViewMain: View {
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @EnvironmentObject var stopViewModel: StopsViewModel
    @EnvironmentObject var userLocationViewModel: LocationViewModel
    
    @Binding var defaultLocation: Bool
    var body: some View {
        ZStack{
            Map(coordinateRegion: defaultLocation ? userLocationViewModel.region.getBinding()! : locationViewModel.searchRegion.getBinding()!,
                showsUserLocation: true,
                annotationItems: stopViewModel.nearbyStops,
                annotationContent: { stop in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: stop.Latitude, longitude: stop.Longitude), tint: .blue)
            })
                .ignoresSafeArea()
            
            // annotationItems: Collection of bus stops to display
            // annotationContent: Styling
            
            // need coordinate data for all the bus stops
            // create a annotation to display for each bus stop inside of Map{  }
            
            
            // make a request to get all nearby stops
            // store in array
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                stopViewModel.getNearbyStops(lat: defaultLocation ? String(format: "%.6f", userLocationViewModel.region.center
                    .latitude) : String(format: "%.6f", locationViewModel.searchRegion.center.latitude), lon: defaultLocation ? String(format: "%.6f", userLocationViewModel.region.center.longitude) : String(format: "%.6f", locationViewModel.searchRegion.center.longitude))
            }
        }
    }
}

struct MapViewMain_Previews: PreviewProvider {
    static var previews: some View {
        MapViewMain(defaultLocation: .constant(true))
    }
}
