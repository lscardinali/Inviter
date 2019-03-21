//
//  JSONLinesDecoder.swift
//  Inviter
//
//  Created by Lucas Salton Cardinali on 21/03/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import Foundation

enum JSONLinesDecoderError: Error {
    case invalidJsonString
}

final class JSONLinesDecoder {

    let decoder: JSONDecoder

    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }

    func decode<T>(_ type: T.Type, data: Data) throws -> [T] where T: Decodable {
        if let jsonString = String(data: data, encoding: .utf8) {
            do {
                var jsonEntries = jsonString.components(separatedBy: .newlines)
                if let lastEntry = jsonEntries.last, lastEntry == "" {
                    jsonEntries.removeLast()
                }
                return try jsonEntries.compactMap({
                    return try decoder.decode(T.self, from: Data($0.utf8))
                })
            } catch {
                throw error
            }
        } else {
            throw JSONLinesDecoderError.invalidJsonString
        }
    }

}
