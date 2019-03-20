//
//  CustomerRepository.swift
//  Inviter
//
//  Created by Lucas Salton Cardinali on 20/03/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import Result

enum CustomerRepositoryError: Error {
    case parsingError
}

final class CustomerRepository {

    let adapter: CustomerLoadable

    init(adapter: CustomerLoadable = CustomerFileAdapter(resourceName: "customers", resourceExtension: "txt")) {
        self.adapter = adapter
    }

    func fetchCustomers(result: (Result<[Customer], CustomerRepositoryError>) -> Void) {
        adapter.fetchCustomerData { customerResult in
            switch customerResult {
            case let .success(resultData):
                if let jsonString = String(data: resultData, encoding: .utf8) {
                    let jsonEntries = jsonString.components(separatedBy: .newlines)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let results: [Customer] = jsonEntries.compactMap({
                        let dataEntry = Data($0.utf8)
                        return try? decoder.decode(Customer.self, from: dataEntry)
                    })
                    result(.success(results))
                } else {
                    result(.failure(.parsingError))
                }
            case .failure:
                result(.failure(.parsingError))
            }
        }
    }
}
