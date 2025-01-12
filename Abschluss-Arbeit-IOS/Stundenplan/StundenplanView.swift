//
//  StundenplanView.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 23.05.24.
//

import SwiftUI

struct StundenplanView: View {
    @StateObject private var viewModel = TimetableViewModel()
    @State private var selectedUser: User?
    @State private var selectedDay: String = "Montag"
    @State private var showAddTimetableView = false
    @State private var dayList: [String] = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag"]
    
    private let userOptions = ["User 1", "User 2", "User 3"]
    
    init(){
        selectedDay = dayList.first ?? ""
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Benutzer", selection: $selectedUser) {
                    ForEach(viewModel.users) { user in
                        Text(user.username)
                    }
                }
                .pickerStyle(.menu)
                List{
                    Picker("Tag", selection: $selectedDay) {
                        ForEach(dayList, id: \.self) { day in
                            Text(day)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                List(viewModel.timetables.filter({ $0.userId == selectedUser?.id && $0.day == selectedDay })) { timetable in
                    VStack(alignment: .leading) {
                        Text("\(timetable.startTime.formatted(date: .omitted, time: .shortened)) - \(timetable.endTime.formatted(date: .omitted, time: .shortened))")
                        Text(timetable.subject)
                    }
                }
            }
            .navigationTitle("Stundenplan")
            .toolbar {
                Button(action: {
                    showAddTimetableView = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddTimetableView) {
                AddTimetableView(viewModel: viewModel, selectedUser: $selectedUser)
            }
            .onAppear {
                viewModel.fetchTimetables()
                viewModel.fetchUsers()
            }
        }
    }}

#Preview {
    StundenplanView()
}





