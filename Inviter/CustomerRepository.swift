//
//  CustomerRepository.swift
//  Inviter
//
//  Created by Lucas Salton Cardinali on 20/03/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import Result

enum CustomerError: Error {
    case noSuchFile
}

final class CustomerRepository {

    func fetchCustomers(result: (Result<[Customer], CustomerError>) -> Void) {
        if let filePath = Bundle.main.url(forResource: "customers", withExtension: "txt") {
            do {
                let data = try Data(contentsOf: filePath)
                let jsonString = String(data: data, encoding: .utf8)
                let jsonEntries = jsonString?.components(separatedBy: .newlines)
                
                let results: [Customer] = jsonEntries.map { entry in
                    let dataEntry = Data(entry.utf8)
                    return try? JSONDecoder().decode([Customer].self, from: data)
                    } ?? []
            
                result(.success(results))
                
            } catch {
                print(error)
                result(.failure(.noSuchFile))
            }
        }
    }
}
