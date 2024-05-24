//
//  ImagePicker.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 10.05.24.
//

//import Foundation
//import UIKit
//
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var selectedImage: UIImage?
//    @Environment(\.presentationMode) var presentationMode
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        var parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController,
//                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let image = info[.originalImage] as? UIImage {
//                parent.selectedImage = image
//            }
//
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
//        // Not needed for this implementation
//    }
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
