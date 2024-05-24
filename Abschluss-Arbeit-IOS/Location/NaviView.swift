//
//  Map.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 13.05.24.
//


//import SwiftUI
//import MapKit
//
//extension CLLocationCoordinate2D {
//    static let home = CLLocationCoordinate2D(latitude: 48.84969617080775, longitude: 12.96563236841419)
//    static let julian = CLLocationCoordinate2D(latitude: 48.69401781889844, longitude: 13.00500252607739)
//}
//
//struct Location: Identifiable {
//    let id = UUID()
//    var title: String
//    var coordinate: CLLocationCoordinate2D
//    
//    static let locations: [Location] = [
//        .init(title: "Home", coordinate: .home),
//        .init(title: "Julian", coordinate: .julian)
//    ]
//}
//
//struct NaviView: View {
//    @StateObject var viewModel = NavigationViewModel()
//
//    var body: some View {
//        Map(coordinateRegion: $viewModel.region, interactionModes: .all, showsUserLocation: true, annotationItems: viewModel.locations) { location in
//            MapAnnotation(coordinate: location.coordinate) {
//                VStack {
//                    Image(systemName: "mappin.and.ellipse").tint(.white).bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                    Text(location.title).tint(.gray)
//                }
//            }
//        }
//        .safeAreaInset(edge: .bottom) {
//            searchAndControlButtons
//        }
//    }
//    
//    var searchAndControlButtons: some View {
//        VStack {
//            TextField("Suche nach Ort:", text: $viewModel.searchQuery, onCommit: {
//                Task {
//                    await viewModel.performSearch()
//                }
//            })
//            .textFieldStyle(.roundedBorder)
//            .padding(.horizontal)
//            .backgroundStyle(Color.gray)
//            
//            controlButtons
//        }
//    }
//    
//    var controlButtons: some View {
//        HStack {
//            Button("Home") {
//                viewModel.goToLocation(.home)
//            }
//            .buttonStyle(.borderedProminent)
//
//            Button("Julian") {
//                viewModel.goToLocation(.julian)
//            }
//            .buttonStyle(.borderedProminent)
//
//            Button("Reset") {
//                viewModel.goToLocation(viewModel.userLocation ?? CLLocationCoordinate2D(latitude: 48.84969617080775, longitude: 12.96563236841419))
//            }
//            .buttonStyle(.borderedProminent)
//            
//            Button(role: .destructive) {                           
//                viewModel.searchQuery = ""
//                viewModel.locations = Location.locations
//            } label: {
//                Image(systemName: "trash")
//            }
//            .buttonStyle(.borderedProminent)
//        }
//        .navigationTitle("Navigation")
//    }
//    
//}
//
//#Preview {
//    NaviView()
//}
