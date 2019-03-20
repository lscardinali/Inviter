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
    let latitude: String
    let longitude: String

    var coordinates: Coordinate? {
        return Coordinate(latitude: latitude, longitude: longitude)
    }
}
