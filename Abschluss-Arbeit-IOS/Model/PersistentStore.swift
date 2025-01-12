////
////  PersistentStore.swift
////  Abschluss-Arbeit-IOS
////
////  Created by Aubeid Barikzi on 03.05.24.
////
//
//import Foundation
//import CoreData
//
//class PersistentStore {
//    
//    var context: NSManagedObjectContext { container.viewContext }
//    private let container: NSPersistentContainer
//    
//    init() {
//        container = NSPersistentContainer(name: "NoteDataModel")
//        container.viewContext.automaticallyMergesChangesFromParent = true
//        container.loadPersistentStores { _, error in
//            if let error {
//                fatalError("Error: \(error)")
//            }
//        }
//    }
//    
//    func save() throws {
//        if context.hasChanges{
//            try context.save()
//        }
//        
//    }
//}
