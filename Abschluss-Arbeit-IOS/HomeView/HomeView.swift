import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @StateObject private var authViewModel = AuthViewModel()
    @State private var showAuthView = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Array(viewModel.photos.enumerated()), id: \.element) { index, photo in
                            VStack {
                                Image(uiImage: UIImage(contentsOfFile: photo) ?? UIImage())
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(10.0)
                                Button(action: {
                                    viewModel.removePhoto(at: index)
                                }) {
                                    Image(systemName: "minus.circle.fill").foregroundColor(.red)
                                }
                            }
                            .padding()
                        }
                    }
                }
                .frame(height: 130)
                
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(minimum: 20)),
                        GridItem(.flexible(minimum: 20))
                    ], content: {
                        ForEach(viewModel.mainItems, id: \.name) { mainItem in
                            HomeViewItemRow(mainItem: mainItem)
                        }
                    })
                }
                
                //                Button(action: {
                //                    NavigationView()
                //                }) {
                //                    Text("Öffne Apple Maps")
                //                        .foregroundColor(.white)
                //                        .padding()
                //                        .background(Color.blue)
                //                        .cornerRadius(10)
                //                }
                //                .padding()
            }
            .overlay(
                Button(action: {
                    showingImagePicker = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.blue)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                    .padding(.trailing, 10)
                    .padding(.bottom, 10),
                alignment: .topTrailing
            )
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $inputImage)
            }
            .navigationBarItems(leading: logoutButton)
            .fullScreenCover(isPresented: $showAuthView) {
                AuthView()
            }
        }
    }
    
    var logoutButton: some View {
        Button(action: {
            authViewModel.logoutButtonTapped()
            showAuthView = true
        }) {
            Text("Logout")
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filePath = paths[0].appendingPathComponent("\(UUID().uuidString).jpg")
        
        if let jpegData = inputImage.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: filePath)
            viewModel.addPhoto(filePath.path)
        }
    }
}
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
