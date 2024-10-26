import SwiftUI
import MapKit
import UserNotifications


struct AddCircleSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var locationData: LocationData
    @State private var cameraPosition: MapCameraPosition
    @State private var isEditing = false
    @ObservedObject var viewModel: ViewModelFixo

    init(locationData: LocationData, startPosition: CLLocationCoordinate2D, viewModel: ViewModelFixo) {
        self.locationData = locationData
        self._cameraPosition = State(initialValue: MapCameraPosition.region(
            MKCoordinateRegion(center: startPosition, span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
        ))
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            MapReader { reader in
                Map(initialPosition: cameraPosition) {
                    if let coordinate = locationData.circleCoordinate {
                        MapCircle(center: coordinate, radius: locationData.radius)
                            .foregroundStyle(Color.cyan.opacity(0.6))
                            .mapOverlayLevel(level: .aboveLabels)
                    }
                }
                .onTapGesture { screenCoord in
                    let pinLocation = reader.convert(screenCoord, from: .local)
                    locationData.circleCoordinate = pinLocation

                    if let newCoordinate = pinLocation {
                        cameraPosition = MapCameraPosition.region(
                            MKCoordinateRegion(center: newCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
                        )
                    }
                }
            }
            VStack {
                HStack {
                    Text("Selecione o local de marcação")
                        .bold()
                        .font(.custom("Chalkduster", size: 18))
                        .foregroundStyle(.white)
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color.green)
                Spacer()

                VStack(spacing: 0) {
                    Slider(
                        value: $locationData.radius,
                        in: 3...250,
                        step: 1,
                        onEditingChanged: { editing in
                            isEditing = editing
                        }
                    )
                    .padding(10)
                    .background(Color.gray)

                    HStack {
                        Button("Cancelar") {
                            dismiss()
                        }.foregroundColor(.white)
                        Spacer()
                        Button("Confirmar") {
                            postUser(latitude: locationData.circleCoordinate!.latitude, longitude: locationData.circleCoordinate!.longitude, radius: locationData.radius) {
                                viewModel.fetch() {
                                    print("Novo local fixo definido")
                                }
                            }
                            dismiss()
                        }.foregroundColor(.white)
                    }
                    .padding(10)
                    .background(Color.green)
                }
            }
        }
    }
}

struct localizacaoView: View {
    @StateObject private var locationData = LocationData()
    @State private var presentAddArticleSheet = false
    @StateObject var viewModelFixo = ViewModelFixo()
    @StateObject var viewModelMovel = ViewModelMovel()
    @State private var cameraPosition: MapCameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -9.4127394, longitude: -40.5155688),
            span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
        )
    )
    @State var animalCoordinate: CLLocationCoordinate2D =
    CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    @State var corTracado:Color = .red
    @State var mostrarTracado:Bool = false
    @State var notificacao_animal: Bool = false
    
    // Array para armazenar as últimas 10 localizações
    @State private var recentLocations: [CLLocationCoordinate2D] = []
    @State private var isAnimating = false


    var body: some View {
        ZStack {
            Map(position: $cameraPosition) {
                if let coordinate = locationData.circleCoordinate {
                    MapCircle(center: coordinate, radius: locationData.radius)
                        .foregroundStyle(Color.green.opacity(0.6))
                        .mapOverlayLevel(level: .aboveLabels)
                }

                // Desenhar a polyline com as últimas localizações
                if recentLocations.count > 1 && mostrarTracado{
                    MapPolyline(coordinates: recentLocations)
                        .stroke(corTracado, lineWidth: 2)
                }
                
                Annotation("Frank", coordinate: animalCoordinate, anchor: .bottom) {
                    Image(systemName: "cat.fill")
                }
            }
            
            VStack {
                if notificacao_animal {
                    
                        Text("Seu pet saiu da área!")
                            .padding(15)
                            .background(.red)
                            .foregroundColor(.white)
                            .cornerRadius(10.0)
                            //.offset(CGSize(width: 0.0, height: 80.0))
                            .font(.custom("Chalkduster", size: 18))
                            .bold()
                            .offset(y: 80 )
                        

                    
                        
                }
                
                Spacer()
                HStack {
                    Button("+") {
                        presentAddArticleSheet.toggle()
                    }
                    .frame(width: 50, height: 50)
                    .font(.title)
                    .bold()
                    .background(Color.white)
                    .clipShape(Circle())
                    .padding(.bottom, 75)
                }
            }
            .sheet(isPresented: $presentAddArticleSheet) {
                AddCircleSheetView(locationData: locationData, startPosition: locationData.circleCoordinate ?? CLLocationCoordinate2D(latitude: -9.4127394, longitude: -40.5155688), viewModel: viewModelFixo)
            }
            
            
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModelFixo.fetch {
                let locaisOrdenados = viewModelFixo.chars.sorted { $0.data < $1.data }
                if let lastLocation = locaisOrdenados.last {
                    locationData.circleCoordinate = CLLocationCoordinate2D(latitude: lastLocation.latitude, longitude: lastLocation.longitude)
                    locationData.radius = lastLocation.radius
                    
                    cameraPosition = MapCameraPosition.region(
                        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lastLocation.latitude, longitude: lastLocation.longitude), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
                    )
                    print("Atualizou!")
                }
            }

            viewModelMovel.startMonitoring()
        } .onDisappear {
            viewModelMovel.stopMonitoring()
        }
        .onReceive(viewModelMovel.$chars) { newChars in
            let locaisOrdenados = viewModelMovel.chars.sorted { $0.data < $1.data }
            
            if let lastLocation = locaisOrdenados.last {
                print("Último local: \(lastLocation)")
                animalCoordinate.latitude = CLLocationDegrees(lastLocation.latitude)
                animalCoordinate.longitude = CLLocationDegrees(lastLocation.longitude)
                
                // Adiciona a nova localização às últimas 10
                if recentLocations.count >= 30 {
                    recentLocations.removeFirst() // Remove a localização mais antiga
                }
                recentLocations.append(animalCoordinate) // Adiciona a nova localização
            }
            
            if let circleCoordinate = locationData.circleCoordinate {
                let difLat = animalCoordinate.latitude - circleCoordinate.latitude
                let difLon = animalCoordinate.longitude - circleCoordinate.longitude
                let distancia = sqrt(pow(difLat, 2) + pow(difLon, 2))
                let raioEmGraus = locationData.radius / 111320.0

                if animalCoordinate.latitude == 0.0 {
                    // Nenhuma ação
                } else if distancia > raioEmGraus {
                    print("O animal passou do raio!")
                    notificacao_animal = true
                    mostrarTracado = true
                } else {
                    print("O animal está dentro do raio.")
                    mostrarTracado = false
                    notificacao_animal = false
                }
            }
        }
    }
}

#Preview {
    localizacaoView()
}
