//
//  ConfiguracaoView.swift
//  safeanimal
//
//  Created by Turma02-24 on 16/10/24.
//

import SwiftUI
import PhotosUI


struct ConfiguracaoView: View {
    @State private var username: String = ""
        @State private var selectedPhoto: UIImage?
        @State private var showImagePicker = false

        var body: some View {
            ZStack {
                // Imagem de fundo
                Image("fundo")
                    .resizable()
                    .scaledToFill()
                    //.ignoresSafeArea()

                VStack {
                  

                    // Seção de foto e nome de usuário
                    HStack {
                        Button(action: {
                            showImagePicker = true
                        }) {
                            if let selectedPhoto = selectedPhoto {
                                Image(uiImage: selectedPhoto)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(.white)
                                    .scaledToFit()
                                    

                                    
                            }
                        }

                        TextField("Nome de usuário", text: $username)
                            .font(.custom("Chalkduster", size: 15))
                            .foregroundStyle(.white)
                            .padding(10)
                            .cornerRadius(5)
                            .frame(width: 200) // Limita a largura do TextField
                    }
                    .padding()
                    .background(Color(red: 123/255, green: 124/255, blue: 98/255))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    Spacer()

                    // Itens do menu
                    VStack(spacing: 10) {
                        MenuItem(title: "Meus Pets")
                            .frame(width: 350)
                            .foregroundStyle(.white)
                        MenuItem(title: "Notificações")
                            .frame(width: 350)
                            .foregroundStyle(.white)
                        MenuItem(title: "Nível do Sensor")
                            .foregroundStyle(.white)
                            .frame(width: 350)
                        MenuItem(title: "Sobre")
                            .foregroundStyle(.white)
                            .frame(width: 350)
                    }
                    .padding(.bottom)

                    Spacer()
                }
                .padding()
                .cornerRadius(10)
                .padding(.horizontal)
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: $selectedPhoto)
                }
            }
        }
    }

    struct MenuItem: View {
        var title: String
        
        var body: some View {
            HStack {
                Text(title)
                    .font(.custom("Chalkduster", size: 20))
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 123/255, green: 124/255, blue: 98/255))
                    .cornerRadius(5)
            }
            .padding(.horizontal, 10)
        }
    }

    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var image: UIImage?

        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        func makeUIViewController(context: Context) -> PHPickerViewController {
            var configuration = PHPickerConfiguration(photoLibrary: .shared())
            configuration.filter = .images
            configuration.selectionLimit = 1
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = context.coordinator
            return picker
        }

        func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

        class Coordinator: NSObject, PHPickerViewControllerDelegate {
            var parent: ImagePicker

            init(_ parent: ImagePicker) {
                self.parent = parent
            }

            func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
                picker.dismiss(animated: true)
                if let result = results.first {
                    if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                        result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                            if let image = image as? UIImage {
                                DispatchQueue.main.async {
                                    self.parent.image = image
                                }
                            }
                        }
                    }
                }
            }
        }
    }

#Preview {
    ConfiguracaoView()
}
