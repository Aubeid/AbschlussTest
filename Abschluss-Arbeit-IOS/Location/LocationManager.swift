//
//  LocationManager.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 10.05.24.
//

//import Foundation
//import CoreLocation
//import Combine
//import SwiftUI
//import MapKit
//
//
//class LocationManager: NSObject, ObservableObject {
//    private let locationManager = CLLocationManager()
//    private(set) var objectWillChange = PassthroughSubject<Void, Never>()
//    
//    @Published var location: CLLocation? {
//        willSet {
//            objectWillChange.send()
//        }
//    }
//    
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//}
//
//extension LocationManager: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        self.location = location
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error getting location: \(error.localizedDescription)")
//    }
//}
