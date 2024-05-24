//
//  PrivateNoteItemRow.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 03.05.24.
//
//
import SwiftUI

struct AddNoteView: View {
    @ObservedObject var viewModel: PrivateNoteViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Neue Notiz", text: $viewModel.newNoteText)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    viewModel.addNote()
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
    AddNoteView(viewModel: PrivateNoteViewModel())
}
