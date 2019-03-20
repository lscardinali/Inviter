//
//  Customer.swift
//  Inviter
//
//  Created by lucas.cardinali on 3/19/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import Foundation

struct Customer: Codable {
    let name: String
    let userId: Int
}

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double

    func compareDistanceWith(coordinate: Coordinate) -> Double {
        let radius = 6371e3
        let delta = (coordinate.longitude - longitude) * Double.pi / 180
        let lat1 = latitude * Double.pi / 180
        let lat2 = coordinate.latitude * Double.pi / 180

        return acos(sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(delta)) * radius
    }
}
