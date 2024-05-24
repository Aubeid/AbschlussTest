//
//  SharedNotesView.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 07.05.24.
//

import SwiftUI

struct SharedNotesView: View {
    
    @StateObject private var viewModel = SharedNoteViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 20)),
                    GridItem(.flexible(minimum: 20))
                ]) {
                    ForEach(viewModel.sharedNotes, id: \.id) { note in
                        NavigationLink(destination: SharedNoteDetailView(note: note, viewModel: viewModel)) {
                            SharedNoteDetailView(note: note, viewModel: viewModel)
                        }
                    }
                }
                .navigationTitle("Gemeinsame Notizen")
                .toolbar {
                    Button {
                        viewModel.showAddNoteSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showAddNoteSheet) {
                AddSharedNoteView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.fetchSharedNotes()
        }
    }
}

#Preview {
    SharedNotesView()
}
