//
//  AddTimetableView.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 23.05.24.
//

import SwiftUI

struct AddTimetableView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TimetableViewModel
    @Binding var selectedUser: User?
    @State private var selectedDay: String = ""
    @State private var subject: String = ""
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    
    private let dayOptions = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag"]
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Tag", selection: $selectedDay) {
                    ForEach(dayOptions, id: \.self) { day in
                        Text(day)
                    }
                }
                
                TextField("Fach", text: $subject)
                
                DatePicker("Startzeit", selection: $startTime, displayedComponents: .hourAndMinute)
                
                DatePicker("Endzeit", selection: $endTime, displayedComponents: .hourAndMinute)
            }
            .navigationBarTitle("Neuer Stundenplaneintrag", displayMode: .inline)
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
    }
    
    private var cancelButton: some View {
        Button("Abbrechen") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private var saveButton: some View {
        Button("Speichern") {
            print(selectedUser)
            if let selectedUser = selectedUser {
                viewModel.addTimetable(userId: selectedUser.id,
                                       day: selectedDay,
                                       subject: subject,
                                       startTime: startTime,
                                       endTime: endTime)
            }
            presentationMode.wrappedValue.dismiss()
        }
    }
}

//#Preview {
//    AddTimetableView(viewModel: TimetableViewModel(), selectedUser: selectedUser)
//}
