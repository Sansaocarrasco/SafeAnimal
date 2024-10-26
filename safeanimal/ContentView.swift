//
//  ContentView.swift
//  safeanimal
//
//  Created by Turma02-24 on 09/10/24.
//

import SwiftUI

class AppSettings: ObservableObject {
    @Published var isNight: Bool = false//
}

struct ContentView: View {
    @State private var showModal = false

    var body: some View {
        NavigationView {
            ZStack {

                Image("fundo")
                    .resizable()
                    .scaledToFill()
                        
//
                VStack {
                    Spacer()

                    ZStack {
                        Rectangle()
                            .fill(Color(red: 123/255, green: 124/255, blue: 98/255))
                            .frame(width: 300, height: 520)
                            .cornerRadius(50)
                            .offset(x: -27, y: 100)

                        Image("Dogs")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 10)
                            .offset(x: -27, y: -100)
                            .onTapGesture {
                                showModal.toggle()
                            }
                            .sheet(isPresented: $showModal) {
                                DynamicImageGridView()
                                    .presentationDetents([.fraction(0.80)])
                            }
                    }

                    Text("Safe Animal")
                        .font(.custom("Chalkduster", size: 40))
                        .foregroundColor(.white)
                        .padding(.top, -240)
                        .offset(x: -27, y: 40)

                    Spacer()

                    NavigationLink(destination: MainScreenView()) {
                        Image("Pegada")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding(.bottom, 20)
                            .offset(x: -27, y: -40)
                            .colorInvert()
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

// Tela de navegação com configurações
struct MainScreenView: View {
    @EnvironmentObject var settings: AppSettings
    @State private var selection = 2


    var body: some View {
        TabView(selection: $selection) {
            consumoView()
                .tabItem {
                    Label("Alimentação", systemImage: "dog")
                }.tag(1)

            localizacaoView()
                .tabItem {
                    Label("Localização", systemImage: "location.circle")
                }.tag(2)

            
            ConfiguracaoView()
            .tabItem {
                Label("Configuração", systemImage: "gear")
            }.tag(3)
        }
        .navigationBarTitle("Safe Animal", displayMode: .inline)
        .navigationBarBackButtonHidden(false)
        .background(Color.gray) // Altera a cor de fundo da TabView para cinza
                .accentColor(.green)
    }
}

// Modal dinâmico com 3 linhas de imagens redondas
struct DynamicImageGridView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Desenvolvedores:")
                .font(.custom("Chalkduster", size: 25))

            HStack(spacing: 20) {
                Image("adhemar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 5)

                Image("stharley")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 5)
            }

            HStack(spacing: 20) {
                Image("joao-pedro")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 5)

                Image("gabriel")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 5)

                Image("alan")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 5)
            }

            Text("Obrigado!")
                .font(.custom("Chalkduster", size: 20))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Image("edilson-almeida")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 1)

                    Image("gabriel-thomaz")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 1)

                    Image("andre-gerez")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 1)

                    Image("eldorado-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 1)

                    Image("hackatruck-logo")//
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 1)

                    Image("univasf-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 1)
                }
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
        .environmentObject(AppSettings())
}
