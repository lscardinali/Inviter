//
//  CustomerLoadable.swift
//  Inviter
//
//  Created by lucas.cardinali on 3/20/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import Result

enum CustomerLoadError: Error {
    case unableToLoad
}

protocol CustomerLoadable: class {
    func fetchCustomerData(result: (Result<Data, CustomerLoadError>) -> Void)
}
