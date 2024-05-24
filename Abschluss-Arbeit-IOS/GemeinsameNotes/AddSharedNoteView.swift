//
//  AddSharedNoteView.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 08.05.24.
//

import SwiftUI

struct AddSharedNoteView: View {
    @ObservedObject var viewModel: SharedNoteViewModel
    @State private var newNoteText = ""
    @State private var selectedPriority: SharedNote.Priority = .low
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Neue Notiz", text: $newNoteText)
                    .textFieldStyle(.roundedBorder)
                
                Picker("Priorität", selection: $selectedPriority) {
                    Text("Hoch").tag(SharedNote.Priority.high)
                    Text("Mittel").tag(SharedNote.Priority.medium)
                    Text("Niedrig").tag(SharedNote.Priority.low)
                }
                .pickerStyle(.segmented)
                
                Button {
                    viewModel.addSharedNote(text: newNoteText, priority: selectedPriority, createdBy: "CurrentUser")
                    newNoteText = ""
                    viewModel.showAddNoteSheet = false
                } label: {
                    Label("Hinzufügen", systemImage: "plus")
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Neue Notiz")
            .toolbar {
                Button {
                    viewModel.showAddNoteSheet = false
                } label: {
                    Image(systemName: "xmark")
                }
            }
        }
    }
}

#Preview {
    AddSharedNoteView(viewModel: SharedNoteViewModel())
}
