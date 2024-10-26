

import Foundation

// Estrutura para os dados que você vai enviar
func postUser(latitude: Double, longitude: Double, radius: Double, completion: @escaping () -> Void) {
    guard let url = URL(string: "http:/10.87.155.214:1880/safeanimalPOST") else {
        print("URL inválida")
        return
    }

    let user = Local(data: 0, latitude: latitude, longitude: longitude, radius: radius)
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        let jsonData = try JSONEncoder().encode(user)
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erro: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                //print("Usuário enviado com sucesso!")
                DispatchQueue.main.async {
                    completion() // Chama o closure após o envio bem-sucedido
                }
            } else {
                print("Erro na resposta da API: \(response.debugDescription)")
            }
        }

        task.resume()
    } catch {
        print("Erro ao codificar dados: \(error.localizedDescription)")
    }
}
