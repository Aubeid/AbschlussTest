//
//  PrivateNoteViewModel.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 03.05.24.
//

import Foundation

class PrivateNoteViewModel: ObservableObject {
    
    @Published var noteList: [Note] = []
    @Published var selectedNote: Note?
    @Published var showAddNoteSheet = false
    @Published var newNoteText = ""
    
    
    
    
    func fetchNotes() {
        do {
            noteList = try Repository.shared.getAllNotes()
        } catch {
            print("Error fetching notes: \(error)")
        }
    }
    
    func deleteNote(_ note: Note) {
        do {
            try Repository.shared.deleteNote(item: note)
            fetchNotes()
        } catch {
            print("Error deleting note: \(error)")
        }
    }
    
    func addNote() {
        do {
            try Repository.shared.addNote(text: newNoteText)
            fetchNotes()
            newNoteText = ""
            showAddNoteSheet = false
        } catch {
            print("Error adding note: \(error)")
        }
    }
    
    func updateNote(_ note: Note, text: String) {
        do {
            
            try Repository.shared.updateNote(note, text: text)
            fetchNotes()
        } catch {
            print("Error updating note: \(error)")
        }
    }
    
    func markNoteAsCompleted(_ note: Note) {
        do {
            note.isCompleted.toggle()
            try Repository.shared.markNoteAsCompleted(note)
            fetchNotes()
        } catch {
            print("Error marking note as completed: \(error)")
        }
    }
    
    
    
    func addButtonTapped() {
        showAddNoteSheet = true
    }
    
    func closeButtonTapped() {
        showAddNoteSheet = false
    }

}

  

    

    
  
