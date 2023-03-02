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
            Map(coordinateRegion: defaultLocation ? region! : searchRegion!, showsUserLocation: true)
                .ignoresSafeArea()
        }
    }
}

struct MapViewMain_Previews: PreviewProvider {
    static var previews: some View {
        MapViewMain(defaultLocation: .constant(true))
    }
}
