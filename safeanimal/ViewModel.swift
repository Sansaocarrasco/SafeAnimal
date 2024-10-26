//
//  ViewModel.swift
//  safeanimal
//
//  Created by Turma02-24 on 10/10/24.
//

import Foundation
import Combine

class ViewModelFixo: ObservableObject {
    @Published var chars: [Local] = []

    func fetch(completion: @escaping () -> Void) {
        guard let url = URL(string: "http://10.87.155.214:1880/safeanimalGET") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Erro na requisição: \(error?.localizedDescription ?? "Erro desconhecido")")
                return
            }

            do {
                let decodedUsers = try JSONDecoder().decode([Local].self, from: data)
                DispatchQueue.main.async {
                    self.chars = decodedUsers
                    completion() // Chama a closure após atualizar os dados
                }
            } catch {
                print("Erro ao decodificar os dados: \(error)")
            }
        }
        task.resume()
    }
}

// TODO: Adaptar para o GPS
class ViewModelMovel: ObservableObject {
    @Published var chars: [Coleira] = []
    private var cancellables = Set<AnyCancellable>()
    private var timer: AnyCancellable?

    init() {
        startMonitoring()
    }

    func startMonitoring() {
        // Configura um timer que faz fetch a cada 5 segundos
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetch {}
            }
    }

    func stopMonitoring() {
        timer?.cancel()
    }

    func fetch(completion: @escaping () -> Void) {
       //guard let url = URL(string: "http://10.87.154.149:1880/coleiraGET") else { return }
        guard let url = URL(string: "http://10.87.155.214:1880/coleiraGET") else { return }

        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Erro na requisição: \(error?.localizedDescription ?? "Erro desconhecido")")
                return
            }

            do {
                let decodedUsers = try JSONDecoder().decode([Coleira].self, from: data)
                DispatchQueue.main.async {
                    self.chars = decodedUsers
                    completion() // Chama a closure após atualizar os dados
                }
            } catch {
                print("Erro ao decodificar os dados: \(error)")
            }
        }
        task.resume()
    }
}


class ViewModelDispenser: ObservableObject {
    @Published var chars: [sensorReader] = []
    private var cancellables = Set<AnyCancellable>()
    private var timer: AnyCancellable?

    init() {
        startMonitoring()
    }

    func startMonitoring() {
        // Configura um timer que faz fetch a cada 5 segundos
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetch {}
            }
    }

    func stopMonitoring() {
        timer?.cancel()
    }

    func fetch(completion: @escaping () -> Void) {
        guard let url = URL(string: "http://10.87.155.214:1880/getSafeAnimal") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Erro na requisição: \(error?.localizedDescription ?? "Erro desconhecido")")
                return
            }

            do {
                let decodedUsers = try JSONDecoder().decode([sensorReader].self, from: data)
                DispatchQueue.main.async {
                    self.chars = decodedUsers
                    completion() // Chama a closure após atualizar os dados
                }
            } catch {
                print("Erro ao decodificar os dados: \(error)")
            }
        }
        task.resume()
    }
}
