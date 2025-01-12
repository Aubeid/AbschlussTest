////
////  SharedNoteDetailView.swift
////  Abschluss-Arbeit-IOS
////
////  Created by Aubeid Barikzi on 08.05.24.
////
//
//import SwiftUI
//
//struct SharedNoteDetailView: View {
//    @State private var editMode = false
//    @State private var newText = ""
//    @State private var newPriority: SharedNote.Priority = .low
//    let note: SharedNote
//    @ObservedObject var viewModel: SharedNoteViewModel
//    
//    var body: some View {
//        VStack {
//            if editMode {
//                TextField("Bearbeite deine Notiz", text: $newText, onEditingChanged: { _ in })
//                    .textFieldStyle(.roundedBorder)
//                    .padding()
//                
//                //                Picker("Priorität", selection: $newPriority) {
//                //                    Text("Hoch").tag(SharedNote.Priority.high)
//                //                    Text("Mittel").tag(SharedNote.Priority.medium)
//                //                    Text("Niedrig").tag(SharedNote.Priority.low)
//                //                }
//                //                .pickerStyle(.segmented)
//                //                .padding()
//                
//                Button(action: {
//                    viewModel.updateSharedNote(note, text: newText, priority: newPriority)
//                    editMode = false
//                }) {
//                    Text("Speichern")
//                }
//            } else {
//                Text(note.text)
//                    .font(.headline)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//            }
//            
//            HStack {
//                Button(action: {
//                    editMode.toggle()
//                    if editMode {
//                        newText = note.text
//                        newPriority = note.priority
//                    }
//                }) {
//                    Image(systemName: "pencil")
//                        .foregroundColor(.blue)
//                }
//                
//                Button(action: {
//                    viewModel.deleteSharedNote(note)
//                }) {
//                    Image(systemName: "trash")
//                        .foregroundColor(.red)
//                }
//                
//                Button(action: {
//                    viewModel.toggleIsCompleted(note)
//                }) {
//                    Image(systemName: note.isCompleted ? "checkmark.square" : "square")
//                        .foregroundColor(.green)
//                }
//            }
//        }
//        .padding()
//        .background(Color.gray.opacity(0.2))
//        .cornerRadius(20)
//        .frame(maxWidth: 400, maxHeight: 400, alignment: .bottomLeading)
//    }
//}
//
//struct SharedNoteDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        let sharedNote = SharedNote(id: "1", text: "Diese Notiz ist eine Beispielnotiz für die Vorschau.", isCompleted: false, priority: .medium, createdBy: "Benutzer", createdAt: Date())
//        
//        return SharedNoteDetailView(note: sharedNote, viewModel: SharedNoteViewModel())
//    }
//}
