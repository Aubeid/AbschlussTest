//
//  HomeViewItemRow.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 29.04.24.
//

import SwiftUI

struct HomeViewItemRow: View {
    let mainItem: MainItemes
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationLink(destination: destinationView()) {
            VStack {
                Text(mainItem.name)
                    .font(.headline)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
                
                Image(systemName: mainItem.image)
                    .font(.largeTitle)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
            .frame(maxWidth: 300,maxHeight: 300, alignment: .bottomLeading)
        }
    }
    
    @ViewBuilder
    private func destinationView() -> some View {
        if mainItem.name == "Private Notizen" {
            PrivateNoteView()
        } else if mainItem.name == "Gemeinsame Notizen" {
            SharedNotesView()
        } else if mainItem.name == "Familien Chat" {
            ChatListView()
        } else if mainItem.name == "Was gibt es zu essen?" {
            MealView()
        } else if mainItem.name == "Stundenplan" {
            StundenplanView()
        }else if mainItem.name == "Wo bist du"{
            
        } else {
            EmptyView()
        }
    }
}
#Preview {
    HomeViewItemRow(mainItem: MainItemes(name: "Stundenplan", image: "graduationcap"))
}
