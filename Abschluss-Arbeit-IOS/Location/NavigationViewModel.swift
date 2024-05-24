//
//  NavigationViewModel.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 13.05.24.
//

//import Foundation
//import CoreLocation
//import MapKit
//
//class NavigationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private var locationManager = CLLocationManager()
//    @Published var region: MKCoordinateRegion
//    @Published var locations: [Location] = Location.locations
//    @Published var searchQuery: String = ""
//    @Published var userLocation: CLLocationCoordinate2D?
//
//    override init() {
//        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.84969617080775, longitude: 12.96563236841419), latitudinalMeters: 5000, longitudinalMeters: 5000)
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//
//    func goToLocation(_ coordinate: CLLocationCoordinate2D) {
//        region.center = coordinate
//        region.span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//    }
//
//    func performSearch() async {
//        guard !searchQuery.isEmpty else { return }
//        let searchRequest = MKLocalSearch.Request()
//        searchRequest.naturalLanguageQuery = searchQuery
//        let search = MKLocalSearch(request: searchRequest)
//        do {
//            let response = try await search.start()
//            if let item = response.mapItems.first {
//                goToLocation(item.placemark.coordinate)
//                locations.append(.init(title: searchQuery, coordinate: item.placemark.coordinate))
//            }
//        } catch {
//            print("Error performing search: \(error.localizedDescription)")
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            userLocation = location.coordinate
//            region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Failed to find user's location: \(error.localizedDescription)")
//    }
//}
