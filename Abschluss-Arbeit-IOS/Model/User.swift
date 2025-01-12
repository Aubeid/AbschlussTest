//
//  User.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 19.04.24.
//

import Foundation
import MapKit

struct User: Identifiable, Codable, Hashable {
    var id: String
    var email: String
    var username: String
    var createdAt: String
    let photoURL: String?
    //let location: GeoPoint?
    
}



//struct GeoPoint: Codable, Hashable {
//    let latitude: Double
//    let longitude: Double
//    
//    var coordinate: CLLocationCoordinate2D {
//        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//    }
//    
//    








