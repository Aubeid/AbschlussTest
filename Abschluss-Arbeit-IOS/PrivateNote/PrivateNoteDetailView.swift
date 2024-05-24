//
//  PrivateNoteDetailView.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 03.05.24.
//

import SwiftUI

struct PrivateNoteDetailView: View {
    @State private var editMode = false
    @State private var newText = ""
    let note: Note
    @ObservedObject var viewModel: PrivateNoteViewModel
    
    var body: some View {
        VStack {
            if editMode {
                TextField("Bearbeite deine Notiz", text: $newText, onEditingChanged: { _ in })
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button(action: {
                    viewModel.updateNote(note, text: newText)
                    editMode = false
                }) {
                    Text("Speichern")
                }
            } else {
                Text(note.text ?? "")
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            HStack {
                Button(action: {
                    editMode.toggle()
                    if editMode {
                        newText = note.text ?? ""
                    }
                }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.blue)
                }
                
                Button(action: {
                    viewModel.deleteNote(note)
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    viewModel.markNoteAsCompleted(note)
                }) {
                    Image(systemName: note.isCompleted ? "checkmark.square" : "square")
                        .foregroundColor(.green)
                    
                    
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .frame(maxWidth: 400, maxHeight: 400, alignment: .bottomLeading)
    }
    
}

struct PrivateNoteDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        let note = Note(context: PersistentStore().context)
        note.text = "Diese Notiz ist eine Beispielnotiz für die Vorschau."
        note.isCompleted = false
        
        return PrivateNoteDetailView(note: note, viewModel: PrivateNoteViewModel())
    }
}
