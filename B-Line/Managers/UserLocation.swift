//
//  userLocation.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-08-22.
//

import CoreLocation
import MapKit

enum mapDefaults{
    static let defaultLocation = CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
}

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    var locationManager: CLLocationManager?
    @Published var region = MKCoordinateRegion(center: mapDefaults.defaultLocation, span: mapDefaults.defaultSpan)
    @Published var location: CLLocation?
    
    override init(){
        super.init()
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
    }
    
    private func checkLocationAuthorization(){
        guard let manager = locationManager else { return }
        
        switch manager.authorizationStatus{
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location services is restricted")
        case .denied:
            print("Location services is denied")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: manager.location?.coordinate ?? mapDefaults.defaultLocation, span: mapDefaults.defaultSpan)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        DispatchQueue.main.async{
            self.location = locations.last
        }
        locationManager?.stopUpdatingLocation()
    }
}
