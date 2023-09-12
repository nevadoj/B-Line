//
//  LocationManager.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-11.
//

// Get the user's collection once, then handle updates with the map view

import CoreLocation
import MapKit
import SwiftUI

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var region = MKCoordinateRegion()
    
    @Published var location: CLLocation?
    
    override init(){
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        DispatchQueue.main.async{
            self.location = locations.last
        }
        locationManager.stopUpdatingLocation()
    }
}

extension MKCoordinateRegion {
    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417),
            center: CLLocationCoordinate2D(latitude: 49.158527, longitude: -122.782270),
            span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
    }
    
    func getBinding() -> Binding<MKCoordinateRegion>? {
        return Binding<MKCoordinateRegion>(.constant(self))
    }
}
