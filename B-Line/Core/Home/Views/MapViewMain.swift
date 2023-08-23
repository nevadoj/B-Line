//
//  MapViewMain.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-23.
//

import SwiftUI
import MapKit

struct MapViewMain: View {
    @StateObject private var locationManager = LocationManager()
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @EnvironmentObject var stopViewModel: StopsViewModel
    
    @Binding var defaultLocation: Bool
    
    var region: Binding<MKCoordinateRegion>? {
        withAnimation{
            guard let location = locationManager.location else {
                return MKCoordinateRegion.defaultRegion().getBinding()
            }
            
            let region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
            
            return region.getBinding()
        }
    }
    
    var searchRegion: Binding<MKCoordinateRegion>? {
        withAnimation{
            guard let searchLocation = locationViewModel.selectedLocationCoordinate else {
                return MKCoordinateRegion.defaultRegion().getBinding()
            }
            
            let searchRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: searchLocation.latitude, longitude: searchLocation.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
            
            return searchRegion.getBinding()            
        }
    }
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: defaultLocation ? region! : searchRegion!,
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
            stopViewModel.getNearbyStops(lat: String(locationManager.location?.coordinate.latitude ?? 49.158527), lon: String(locationManager.location?.coordinate.longitude ?? -122.782270))
            print(stopViewModel.nearbyStops)
        }
    }
}

struct MapViewMain_Previews: PreviewProvider {
    static var previews: some View {
        MapViewMain(defaultLocation: .constant(true))
    }
}
