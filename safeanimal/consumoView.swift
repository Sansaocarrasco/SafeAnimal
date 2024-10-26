//
//  consumoView.swift
//  safeanimal
//
//  Created by Turma02-24 on 09/10/24.
//

import SwiftUI

struct consumoView: View {
    
    @StateObject var sensorData = ViewModelDispenser()
    
    var empty: Float = 10
    var full: Float = 3.0
    @State var lastRegister: sensorReader? // Torne opcional

    var body: some View {
        
        ZStack{
            Image("fundo")
                .resizable()
                .scaledToFill()
            VStack {
                HStack {
                    VStack {
                        Text("Comida")
                            .font(.custom("Chalkduster", size: 20))
                        
                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 40)
                                .fill(Color.white)
                                .frame(width: 70, height: 200)
                            
                            if let lastRegister = lastRegister {
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color.green)
                                    .frame(width: 70, height: alturaAtual(currentDistance: Float(lastRegister.distance) ?? 0)) // Corrigido
                                    .animation(.easeInOut)
                            }
                            
                            RoundedRectangle(cornerRadius: 40)
                                .opacity(0.001)
                                .frame(width: 70, height: 200)
                                .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.brown, lineWidth: 8))
                        }
                    }
                    
                    VStack {
                        Text("Água")
                            .font(.custom("Chalkduster", size: 20))
                        
                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 40)
                                .fill(Color.white)
                                .frame(width: 70, height: 200)

                            if let lastRegister = lastRegister {
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color.blue)
                                    .frame(width: 70, height: alturaAtual(currentDistance: Float(lastRegister.distance) ?? 0)) // Corrigido
                                    .cornerRadius(5)
                                    .animation(.easeInOut)
                            }
                            
                            RoundedRectangle(cornerRadius: 40)
                                .opacity(0.001)
                                .frame(width: 70, height: 200)
                                .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.brown, lineWidth: 8))
                        }
                    }.padding()
                }
                .padding()
            }
            .onAppear() {
                sensorData.startMonitoring()
            }
            .onDisappear {
                sensorData.stopMonitoring()
            }
            .onReceive(sensorData.$chars) { newChars in
                lastRegister = newChars.max(by: { $0.date < $1.date }) // Use a nova variável
                print("Recebi dados do dispenser: \(lastRegister?.distance)")
            }
        }
        
        
    }
    
    func alturaAtual(currentDistance: Float) -> CGFloat {
        let currentLevel = (currentDistance - empty) / (full - empty)
        return CGFloat(max(0, min(200 * currentLevel, 200))) // Limita a altura entre 0 e 200
    }
}

#Preview {
    consumoView()
}
