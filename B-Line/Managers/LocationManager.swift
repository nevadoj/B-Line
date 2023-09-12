//
//  LocationManager.swift
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
    
    // User Location
    var locationManager: CLLocationManager?
    @Published var region = MKCoordinateRegion(center: mapDefaults.defaultLocation, span: mapDefaults.defaultSpan)
    @Published var location: CLLocation?
    
    // Search
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init(){
        super.init()
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
        
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
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
    
    func resetLocation(){
        guard let manager = locationManager else { return }
        region = MKCoordinateRegion(center: manager.location?.coordinate ?? mapDefaults.defaultLocation, span: mapDefaults.defaultSpan)
    }
}

// Search functions
extension LocationViewModel{
    func selectLocation(_ localSearch: MKLocalSearchCompletion){
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if  let error = error{
                print("ERROR: Location searched failed with error \(error.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else { return }
            
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), span: mapDefaults.defaultSpan)
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
}

extension LocationViewModel: MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
