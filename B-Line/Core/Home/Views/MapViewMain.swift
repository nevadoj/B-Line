//
//  MapViewMain.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-23.
//

import SwiftUI
import MapKit

struct MapViewMain: View {
    @EnvironmentObject var stopViewModel: StopsViewModel
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    @Binding var defaultLocation: Bool
    @State private var selectedStop: SavedStops?
    
    private var region: Binding<MKCoordinateRegion>{
        Binding{
            locationViewModel.region
        } set: { region in
            DispatchQueue.main.async{
                locationViewModel.region = region
            }
        }
    }
    
    var body: some View {
        ZStack{
//            Map(coordinateRegion: region,
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
            Map(coordinateRegion: region,
                showsUserLocation: true,
                annotationItems: stopViewModel.nearbyStops,
                annotationContent: { stop in
                withAnimation(.easeOut(duration: 0.15)){
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: stop.BusStop.Latitude, longitude: stop.BusStop.Longitude), tint: .blue)
                }
            })
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    stopViewModel.getNearbyStopsTask(lat: String(format: "%.6f", locationViewModel.region.center.latitude), lon: String(format: "%.6f", locationViewModel.region.center.longitude))
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
            .environmentObject(StopsViewModel())
            .environmentObject(LocationViewModel())
    }
}
