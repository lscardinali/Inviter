//
//  JSONLinesDecoderSpec.swift
//  InviterTests
//
//  Created by Lucas Salton Cardinali on 21/03/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble

@testable import Inviter

class JSONLinesDecoderSpec: QuickSpec {

    var sut: JSONLinesDecoder!

    override func spec() {
        describe("The JSON Lines Decoder") {
            context("When parsing a json") {
                it("Should return valid object when json is valid") {
                    //swiftlint:disable line_length
                    let jsonString = "{\"latitude\": \"52.986375\", \"user_id\": 12, \"name\": \"Christina McArdle\", \"longitude\": \"-6.043701\"}\n {\"latitude\": \"51.92893\", \"user_id\": 1, \"name\": \"Alice Cahill\", \"longitude\": \"-10.27699\"}\n {\"latitude\": \"51.8856167\", \"user_id\": 2, \"name\": \"Ian McArdle\", \"longitude\": \"-10.4240951\"}\n"

                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    self.sut = JSONLinesDecoder(decoder: decoder)

                    do {
                        let customers = try self.sut.decode(Customer.self, data: Data(jsonString.utf8))
                        expect(customers).to(beAKindOf([Customer].self))
                        expect(customers.count).to(equal(3))
                    } catch {
                        fail("shouldn't fail parsing a valid json")
                    }
                }

                it("Should throw error if json is valid") {
                    //swiftlint:disable line_length
                    let jsonString = "{\"latituder_id\": 2, \"name\": \"Ian McArdle\", \"longitude\": \"-10.4240951\"}\n"

                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    self.sut = JSONLinesDecoder(decoder: decoder)

                    do {
                        _ = try self.sut.decode(Customer.self, data: Data(jsonString.utf8))
                        fail("shouldn't succeed when parsing wrong json")
                    } catch {
                        expect(error).to(beAKindOf(Error.self))
                    }
                }
            }

        }
    }
}
