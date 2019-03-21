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
    let decoder: JSONLinesDecoder

    init(adapter: CustomerLoadable = CustomerFileAdapter(resourceName: "customers", resourceExtension: "txt")) {
        self.adapter = adapter
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder = JSONLinesDecoder(decoder: jsonDecoder)
    }

    func fetchCustomers(within distance: Double, from coordinate: Coordinate,
                        orderedById: Bool, result: (Result<[Customer], CustomerRepositoryError>) -> Void) {
        adapter.fetchCustomerData { customerResult in
            switch customerResult {
            case let .success(resultData):
                do {
                    var customers = try decoder.decode(Customer.self, data: resultData)
                    customers = customers.filter({
                        if let validCoordinate = $0.coordinates {
                            return validCoordinate.distanceFrom(coordinate: coordinate) < distance
                        }
                        return false
                    })

                    if orderedById {
                        customers = customers.sorted(by: {$0.userId < $1.userId})
                    }
                    result(.success(customers))
                } catch {
                    result(.failure(.parsingError))
                }
            case .failure:
                result(.failure(.parsingError))
            }
        }
    }
}
