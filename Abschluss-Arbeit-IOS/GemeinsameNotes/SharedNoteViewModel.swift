//
//  NoteViewModel.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 07.05.24.
//

import Combine
import FirebaseFirestore

class SharedNoteViewModel: ObservableObject {
    @Published var sharedNotes: [SharedNote] = []
    @Published var showAddNoteSheet = false
    private var cancellables: Set<AnyCancellable> = []
    private let db = Firestore.firestore()
    
    init() {
        fetchSharedNotes()
    }
    
    func fetchSharedNotes() {
        db.collection("notes").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
                return
            }
            
            self.sharedNotes = querySnapshot?.documents.compactMap { document in
                let data = document.data()
                let text = data["text"] as? String ?? ""
                let isCompleted = data["isCompleted"] as? Bool ?? false
                let priorityRawValue = data["priority"] as? String ?? ""
                let priority = SharedNote.Priority(rawValue: priorityRawValue) ?? .low
                let createdBy = data["createdBy"] as? String ?? ""
                let createdAt = (data["createdAt"] as? Timestamp)?.dateValue() ?? Date()
                
                return SharedNote(id: document.documentID, text: text, isCompleted: isCompleted, priority: priority, createdBy: createdBy, createdAt: createdAt)
            } ?? []
        }
    }
    
    func addSharedNote(text: String, priority: SharedNote.Priority, createdBy: String) {
        let data: [String: Any] = [
            "text": text,
            "isCompleted": false,
            "priority": priority.rawValue,
            "createdBy": createdBy,
            "createdAt": Timestamp(date: Date())
        ]
        
        db.collection("notes").addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document added successfully")
            }
        }
    }
    
    func updateSharedNote(_ note: SharedNote, text: String, priority: SharedNote.Priority) {
        let data: [String: Any] = [
            "text": text,
            "isCompleted": note.isCompleted,
            "priority": priority.rawValue
        ]
        
        db.collection("notes").document(note.id).updateData(data) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
            } else {
                print("Document updated successfully")
            }
        }
    }
    
    func deleteSharedNote(_ note: SharedNote) {
        db.collection("notes").document(note.id).delete { error in
            if let error = error {
                print("Error deleting document: \(error.localizedDescription)")
            } else {
                print("Document deleted successfully")
            }
        }
    }
    
    
    func toggleIsCompleted(_ note: SharedNote) {
        let data: [String: Any] = [
            "isCompleted": !note.isCompleted
        ]
        
        db.collection("notes").document(note.id).updateData(data) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
            } else {
                print("Document updated successfully")
            }
        }
    }
}
