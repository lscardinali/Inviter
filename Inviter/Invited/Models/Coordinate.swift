//
//  Coordinate.swift
//  Inviter
//
//  Created by lucas.cardinali on 3/20/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import Foundation

enum CoordinateError: Error {
    case invalidValues
}
struct Coordinate {
    let latitude: Double
    let longitude: Double

    private func radiansOf(_ value: Double) -> Double {
        return value * Double.pi / 180
    }

    init?(latitude: String, longitude: String) {
        if let validLatitude = Double(latitude), let validLongitude = Double(longitude) {
            self.latitude = validLatitude
            self.longitude = validLongitude
        } else {
           return nil
        }
    }

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    func distanceFrom(coordinate: Coordinate) -> Double {
        let radius = 6371e3
        let delta = radiansOf(coordinate.longitude - longitude)
        let lat1 = radiansOf(latitude)
        let lat2 = radiansOf(coordinate.latitude)

        return (acos(sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(delta)) * radius) / 1000
    }
}
