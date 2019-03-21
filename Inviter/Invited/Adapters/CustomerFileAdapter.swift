//
//  CustomerFileAdapter.swift
//  Inviter
//
//  Created by lucas.cardinali on 3/20/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import Result

final class CustomerFileAdapter: CustomerLoadable {
    let resourceName: String
    let resourceExtension: String

    init(resourceName: String, resourceExtension: String) {
        self.resourceName = resourceName
        self.resourceExtension = resourceExtension
    }

    func fetchCustomerData(result: (Result<Data, CustomerLoadError>) -> Void) {
        if let filePath = Bundle.main.url(forResource: resourceName, withExtension: resourceExtension) {
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
