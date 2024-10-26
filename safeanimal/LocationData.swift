//
//  LocationData.swift
//  safeanimal
//
//  Created by Turma02-24 on 10/10/24.
//

import SwiftUI
import MapKit

class LocationData: ObservableObject {
    @Published var circleCoordinate: CLLocationCoordinate2D?
    @Published var radius: CLLocationDistance = 100
}

