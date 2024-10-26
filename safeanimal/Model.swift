//
//  Model.swift
//  safeanimal
//
//  Created by Turma02-24 on 10/10/24.
//

import Foundation

struct Local: Codable, Hashable{
    let data: Int
    let latitude: Double
    let longitude: Double
    let radius: Double
}

struct Coleira: Codable, Hashable {
    let latitude: Float
    let longitude: Float
    let data: Int
}

struct sensorReader: Codable, Hashable{
    let _id: String
    let _rev: String
    let distance: String
    let date: Int
}

