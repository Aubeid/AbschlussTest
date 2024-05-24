//
//  TimetableViewModel.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 23.05.24.
//

import Foundation
import FirebaseFirestore

class TimetableViewModel: ObservableObject {
    @Published var timetables: [Timetable] = []
    @Published var users: [User] = []
    private let currentUserId = AuthRepository.shared.checkUser()?.uid ?? ""
    
    private let firestore = Firestore.firestore()
    
    init() {
        fetchTimetables()
        fetchUsers()
        
    }
    
    func fetchUsers() {
        firestore.collection("users")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching users: \(error.localizedDescription)")
                    return
                }
                
                self.users = querySnapshot?.documents.compactMap { document in
                    guard let user = try? document.data(as: User.self),
                          user.id != self.currentUserId else {
                        return nil
                    }
                    print(user)
                    return user
                } ?? []
                print(self.users)
            }
    }
    

    
    func fetchTimetables() {
        firestore.collection("timetables")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching timetables: \(error.localizedDescription)")
                    return
                }
                
                self.timetables = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Timetable.self)
                } ?? []
                
                // Sortiere die Stundenpläne nach Startzeit
                self.timetables.sort { $0.startTime < $1.startTime }
            }
    }
    
    func addTimetable(userId: String, day: String, subject: String, startTime: Date, endTime: Date) {
        let timetable = Timetable(userId: userId, day: day, subject: subject, startTime: startTime, endTime: endTime)
        do {
            print("ADDTime")
            _ = try firestore.collection("timetables").addDocument(from: timetable)
            
        } catch {
            print("Error adding timetable: \(error.localizedDescription)")
        }
    }
    
    func updateTimetable(_ timetable: Timetable, day: String, subject: String, startTime: Date, endTime: Date) {
        guard let id = timetable.id else {
            return
        }
        
        let updatedTimetable = Timetable(id: id, userId: timetable.userId, day: day, subject: subject, startTime: startTime, endTime: endTime)
        do {
            try firestore.collection("timetables").document(id).setData(from: updatedTimetable)
        } catch {
            print("Error updating timetable: \(error.localizedDescription)")
        }
    }
    
    func deleteTimetable(_ timetable: Timetable) {
        guard let id = timetable.id else {
            return
        }
        
        firestore.collection("timetables").document(id).delete { error in
            if let error = error {
                print("Error deleting timetable: \(error.localizedDescription)")
            }
        }
    }
}
