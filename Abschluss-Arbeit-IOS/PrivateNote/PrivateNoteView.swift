////
////  PrivateNoteView.swift
////  Abschluss-Arbeit-IOS
////
////  Created by Aubeid Barikzi on 29.04.24.
////
//
//import SwiftUI
//
//struct PrivateNoteView: View {
//    @StateObject var viewModel = PrivateNoteViewModel()
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                LazyVGrid(columns: [
//                    GridItem(.flexible(minimum: 20)),
//                    GridItem(.flexible(minimum: 20))
//                ], content: {
//                    ForEach(viewModel.noteList, id: \.id) { note in
//                        NavigationLink(destination: PrivateNoteDetailView(note: note, viewModel: viewModel)) {
//                            PrivateNoteDetailView(note: note, viewModel: viewModel)
//                        }
//                    }
//                })
//                
//                .navigationTitle("Private Notizen")
//                .toolbar {
//                    Button {
//                        viewModel.showAddNoteSheet = true
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//            
//            .sheet(isPresented: $viewModel.showAddNoteSheet) {
//                AddNoteView(viewModel: viewModel)
//            }
//        }
//        .onAppear {
//            viewModel.fetchNotes()
//        }
//    }
//}
//
//#Preview {
//    PrivateNoteView()
//}
