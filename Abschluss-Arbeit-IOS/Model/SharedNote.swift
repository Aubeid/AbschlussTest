////
////  NoteFirebase.swift
////  Abschluss-Arbeit-IOS
////
////  Created by Aubeid Barikzi on 07.05.24.
////
//
//import Foundation
//import SwiftUI
//
//struct SharedNote: Identifiable, Codable {
//    var id: String
//    var text: String
//    var isCompleted: Bool
//    var priority: Priority
//    var createdBy: String
//    var createdAt: Date
//    
//    enum Priority: String, Codable {
//        case high = "Hoch"
//        case medium = "Mittel"
//        case low = "Niedrig"
//        
//        var color: Color {
//            switch self {
//            case .high:
//                return .red
//            case .medium:
//                return .orange
//            case .low:
//                return .green
//            }
//        }
//    }
//}
