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
    @State private var selectedStop: SavedStops?
    @State private var region = MKCoordinateRegion(center: mapDefaults.defaultLocation, span: mapDefaults.defaultSpan)
    
    var body: some View {
        ZStack{
//            Map(coordinateRegion: defaultLocation ? userLocationViewModel.region.getBinding()! : locationViewModel.searchRegion.getBinding()!,
//                showsUserLocation: true,
//                annotationItems: stopViewModel.nearbyStops,
//                annotationContent: { stop in
//                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: stop.BusStop.Latitude, longitude: stop.BusStop.Longitude)){
//                        AnnotationView()
//                            .shadow(radius: 10)
//                            .onTapGesture {
//                                selectedStop = stop
//                                print(stop)
//                            }
//                    }
//                }
//            )
            
            // No published view errors
            Map(coordinateRegion: $region,
                showsUserLocation: true,
                annotationItems: stopViewModel.nearbyStops,
                annotationContent: { stop in
                withAnimation(.easeOut(duration: 0.15)){
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: stop.BusStop.Latitude, longitude: stop.BusStop.Longitude), tint: .blue)
                }
            })
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    DispatchQueue.main.async {
                        region = defaultLocation ? userLocationViewModel.region : locationViewModel.searchRegion
                    }
                    stopViewModel.getNearbyStopsTask(lat: defaultLocation ? String(format: "%.6f", userLocationViewModel.region.center
                        .latitude) : String(format: "%.6f", locationViewModel.searchRegion.center.latitude), lon: defaultLocation ? String(format: "%.6f", userLocationViewModel.region.center.longitude) : String(format: "%.6f", locationViewModel.searchRegion.center.longitude))
                }
            }
            .onChange(of: defaultLocation){ loc in
                if(loc){
                    DispatchQueue.main.async {
                        region = userLocationViewModel.region
                    }
                }
                else{
                    DispatchQueue.main.async {
                        region = locationViewModel.searchRegion
                    }
                }
            }
            .ignoresSafeArea()
        }
        .sheet(item: $selectedStop){ stop in
            NavigationView{
                DiscoverStopView(stop: stop)
            }
            .presentationDetents([.medium])
        }
    }
}

struct MapViewMain_Previews: PreviewProvider {
    static var previews: some View {
        MapViewMain(defaultLocation: .constant(true))
            .environmentObject(LocationSearchViewModel())
            .environmentObject(StopsViewModel())
            .environmentObject(LocationViewModel())
        
    }
}
