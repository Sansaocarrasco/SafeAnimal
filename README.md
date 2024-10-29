# SafeAnimal
![SafeAnimal Logo](https://github.com/user-attachments/assets/2d9a005a-e29a-4d0e-bdc6-33dc2ac8e37e)

**SafeAnimal** é um projeto inovador desenvolvido em **Swift**, utilizando o padrão de software MVVM (Model-View-ViewModel). Este projeto visa proporcionar segurança e monitoramento para animais de estimação por meio de uma coleira digital. Com funcionalidades como rastreamento em tempo real e monitoramento de ração e água, o SafeAnimal garante que você sempre saiba onde está seu animal e se ele está bem alimentado e hidratado. O projeto foi desenvolvido durante o curso de capacitação do Instituto de Pesquisa Eldorado, chamado **Hackatruck Maker Space**.

## Hackatruck
![Hackatruck](https://github.com/user-attachments/assets/45c261cc-1e20-4199-84b3-233f4526d7d8)

O Hackatruck oferece capacitação presencial em programação, com foco na linguagem Swift e sua aplicação em serviços de cloud, especialmente em Serviços Cognitivos.

## Funcionalidades

- **Rastreamento GPS em Tempo Real**: Monitore a localização do seu animal em tempo real. O usuário pode delimitar uma área no mapa, definindo um raio seguro. Caso o animal saia dessa área, um alerta será enviado ao usuário imediatamente.

- **Monitoramento de Alimentação**: Um sensor ultrassônico verifica constantemente se o seu animal possui água e comida disponíveis. Dois retângulos indicam a quantidade de alimento e água com cores diferentes.

- **Interface Intuitiva**: A interface é projetada para ser fácil de usar, permitindo que os usuários definam áreas de segurança e monitorem as condições de alimento e água rapidamente.

## Tecnologias Utilizadas

- **Swift**: Linguagem principal utilizada para o desenvolvimento da aplicação.
- **Node-RED**: Para orquestração de dados e criação de fluxos de trabalho.
- **Swift IoT**: Integração de dispositivos IoT.
- **IBM Cloudant**: Armazenamento e gerenciamento de dados em nuvem.
- **HC-SR04**: Circuito integrado utilizado para monitoramento de água e ração.
- **ESP8266**: Circuito integrado utilizado para integrar o sensor ultrassônico com o software.

## Telas do Aplicativo
![Tela do Aplicativo](https://github.com/user-attachments/assets/a5cb8cfc-e787-4f24-acf6-69646b9ee879)

### Desenvolvedores
![Desenvolvedores](https://github.com/user-attachments/assets/2ae19869-7e59-4c7c-9abd-328b7b044110)

## Circuitos Integrados (CIs)
- 1 x **ESP8266**  
- 1 x **HC-SR04**  

### Esquema do Sensor Ultrassônico HC-SR04 + ESP8266
![Esquema do Sensor](https://github.com/user-attachments/assets/c175148b-8365-4157-90dd-3295fc3f8f87)

### Implementação Real (Telas)
<div style="display: flex; justify-content: space-between;">
    <img src="https://github.com/user-attachments/assets/f94952e9-ab40-4f31-a52d-00c48c1eba9b" width="45%" />
    <img src="https://github.com/user-attachments/assets/7d874579-4580-413e-825f-12bc47fe7872" width="45%" />
</div>

### Implementação Real (Monitor de Comida e Água)
![Monitor de Comida e Água](https://github.com/user-attachments/assets/8960626d-255e-4e17-81c0-09ceb6fe215f)

## Instalação
1. Clone este repositório:
   ```bash
   git clone https://github.com/Sansaocarrasco/SafeAnimal.git

2. Modifique o arquivo (ViewModel.swift) para fazer o GET no banco de sua preferencia:
   ```bash
    guard let url = URL(string: "--Coloque aqui seu GET do banco de dados--")

3. Modifique o arquivo (API.swift) para fazer o POST no banco de sua preferencia:
   ```bash
    guard let url = URL(string: "--Coloque aqui seu POST do banco de dados--")
   
4. Agora é só testar em um compilador iOS de sua preferência.
