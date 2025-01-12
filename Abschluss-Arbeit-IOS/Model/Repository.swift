////
////  Repository.swift
////  Abschluss-Arbeit-IOS
////
////  Created by Aubeid Barikzi on 03.05.24.
////
//
//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//import Combine
//
//class Repository{
//    
//    private let db = Firestore.firestore()
//    
//    static let shared = Repository()
//    private let store = PersistentStore()
//    
//    func getAllNotes() throws -> [Note] {
//        let request = Note.fetchRequest()
//        return try store.context.fetch(request)
//    }
//    
//    func deleteNote(item: Note) throws {
//        store.context.delete(item)
//        try store.save()
//    }
//    
//    func addNote(text: String) throws{
//        let newNote = Note(context: store.context)
//        newNote.id = UUID()
//        newNote.text = text
//        newNote.isCompleted = false
//        
//        try store.save()
//    }
//    
//    func updateNote(_ note: Note, text: String) throws {
//        note.text = text
//        try store.save()
//    }
//    
//    func markNoteAsCompleted(_ note: Note) throws {
//        note.isCompleted = true
//        try store.save()
//    }
//    
//    func addSharedNote(text: String) {
//        let data: [String: Any] = [
//            "text": text,
//            "isCompleted": false,
//            "createdAt": Timestamp(date: Date())
//        ]
//        
//        db.collection("notes").addDocument(data: data) { error in
//            if let error = error {
//                print("Error adding document: \(error.localizedDescription)")
//            } else {
//                print("Document added successfully")
//            }
//        }
//    }
//    
//    func addSharedNote(text: String, priority: SharedNote.Priority, createdBy: String) {
//        let data: [String: Any] = [
//            "text": text,
//            "isCompleted": false,
//            "priority": priority.rawValue,
//            "createdBy": createdBy,
//            "createdAt": Timestamp(date: Date())
//        ]
//        
//        db.collection("notes").addDocument(data: data) { error in
//            if let error = error {
//                print("Error adding document: \(error.localizedDescription)")
//            } else {
//                print("Document added successfully")
//            }
//        }
//    }
//    
//    func getAllSharedNotes(completion: @escaping ([SharedNote]) -> Void) {
//        db.collection("notes").getDocuments { querySnapshot, error in
//            if let error = error {
//                print("Error getting documents: \(error.localizedDescription)")
//                completion([])
//            } else {
//                let notes = querySnapshot?.documents.compactMap { document -> SharedNote? in
//                    let data = document.data()
//                    let text = data["text"] as? String ?? ""
//                    let isCompleted = data["isCompleted"] as? Bool ?? false
//                    let priorityRawValue = data["priority"] as? String ?? ""
//                    let priority = SharedNote.Priority(rawValue: priorityRawValue) ?? .low
//                    let createdBy = data["createdBy"] as? String ?? ""
//                    let createdAt = (data["createdAt"] as? Timestamp)?.dateValue() ?? Date()
//                    
//                    return SharedNote(id: document.documentID, text: text, isCompleted: isCompleted, priority: priority, createdBy: createdBy, createdAt: createdAt)
//                } ?? []
//                
//                completion(notes)
//            }
//        }
//    }
//    
//    func updateSharedNote(_ note: SharedNote, text: String, priority: SharedNote.Priority) {
//        let data: [String: Any] = [
//            "text": text,
//            "isCompleted": note.isCompleted,
//            "priority": priority.rawValue
//        ]
//        
//        db.collection("notes").document(note.id).updateData(data) { error in
//            if let error = error {
//                print("Error updating document: \(error.localizedDescription)")
//            } else {
//                print("Document updated successfully")
//            }
//        }
//    }    
//}
