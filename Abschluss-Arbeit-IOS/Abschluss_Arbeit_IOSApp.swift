//
//  Abschluss_Arbeit_IOSApp.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 19.04.24.
//

import SwiftUI
import Firebase

@main
struct Abschluss_Arbeit_IOSApp: App {
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
            
        }        
    }
}
