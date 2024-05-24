import Foundation
import CoreLocation
import FirebaseFirestore
import MapKit

class HomeViewModel: ObservableObject {
    
    @Published var photos: [String] = []
    @Published var mainItems: [MainItemes] = []
    @Published var users: [User] = [] 
    //private let locationManager = LocationManager()
    private let firestore = Firestore.firestore()
    
//    
//    func openMapsWithUserLocation() -> MapViewWrapper {
//        if let userLocation = userLocation {
//            return MapViewWrapper(coordinate: userLocation.coordinate)
//        } else {
//            return MapViewWrapper(coordinate: nil)
//        }
//    }
//    
//    var userLocation: CLLocation? {
//           locationManager.location
//       }
    
    init() {
           mainItems = loadItems()
       }
  

    func addPhoto(_ photo: String) {
        DispatchQueue.main.async {
            self.photos.append(photo)
        }
    }

    func removePhoto(at index: Int) {
        DispatchQueue.main.async {
            self.photos.remove(at: index)
        }
    }
    
    func loadItems() ->[MainItemes] {
        
        mainItems =  [ MainItemes(name: "Private Notizen", image: "note"),
                       MainItemes(name: "Gemeinsame Notizen", image: "note.text"),
                       MainItemes(name: "Familien Chat", image: "message"),
                       MainItemes(name: "Was gibt es zu essen?", image: "fork.knife"),
                       MainItemes(name: "Stundenplan", image: "graduationcap"),
                       MainItemes(name: "Wo bist du?", image: "graduationcap")]
        
    return mainItems
       
       
    }
    
    func fetchUsers() {
            firestore.collection("users").addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching users: \(error.localizedDescription)")
                    return
                }

                self.users = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: User.self)
                } ?? []
            }
        }
    
    
    func logoutButtonTapped() {
        do {
            try AuthRepository.shared.logout()
           
        } catch {
            print("Error logging out: \(error.localizedDescription)")
        }
    }
}
