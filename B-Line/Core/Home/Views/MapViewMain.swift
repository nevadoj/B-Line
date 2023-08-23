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
    
    var region: MKCoordinateRegion{
        guard let location = userLocationViewModel.location else{
            return MKCoordinateRegion(center: mapDefaults.defaultLocation, span: mapDefaults.defaultSpan)
        }
        
        let region = MKCoordinateRegion(center: location.coordinate, span: mapDefaults.defaultSpan)
        return region
    }
    
    var searchRegion: MKCoordinateRegion {
            guard let searchLocation = locationViewModel.selectedLocationCoordinate else {
                return MKCoordinateRegion.defaultRegion()
            }
            
            let searchRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: searchLocation.latitude, longitude: searchLocation.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
            
            return searchRegion
        }
    
    @Binding var defaultLocation: Bool
    var body: some View {
        ZStack{
            Map(coordinateRegion: defaultLocation ? region.getBinding()! : searchRegion.getBinding()!,
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
            stopViewModel.getNearbyStops(lat: defaultLocation ? String(format: "%.6f", region.center
                .latitude) : String(format: "%.6f", searchRegion.center
                    .latitude), lon: defaultLocation ? String(format: "%.6f", region.center.longitude) : String(format: "%.6f", searchRegion.center
                        .longitude))
        }
    }
}

struct MapViewMain_Previews: PreviewProvider {
    static var previews: some View {
        MapViewMain(defaultLocation: .constant(true))
    }
}
