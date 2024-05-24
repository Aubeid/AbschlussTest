//
//  File.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 23.05.24.
//

import Foundation
import FirebaseFirestore

struct Timetable: Identifiable, Codable {
    var id: String?
    var userId: String
    var day: String
    var subject: String
    var startTime: Date
    var endTime: Date
}
