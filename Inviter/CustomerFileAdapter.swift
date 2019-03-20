//
//  CustomerFileAdapter.swift
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

final class CustomerFileAdapter: CustomerLoadable {

    func fetchCustomerData(result: (Result<Data, CustomerLoadError>) -> Void) {
        if let filePath = Bundle.main.url(forResource: "customers", withExtension: "txt") {
            do {
                let data = try Data(contentsOf: filePath)
                result(.success(data))
            } catch {
                result(.failure(.unableToLoad))
            }
        } else {
            result(.failure(.unableToLoad))
        }
    }
}
