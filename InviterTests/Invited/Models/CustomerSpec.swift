//
//  CustomerSpec.swift
//  InviterTests
//
//  Created by lucas.cardinali on 3/20/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble

@testable import Inviter

class CustomerSpec: QuickSpec {

    var sut: Customer!

    override func spec() {
        describe("The Customer Model") {
            context("When instantiated from decoding a json") {
                it("Should return a valid Customer") {
                    //swiftlint:disable line_length
                    let jsonString = "{\"latitude\": \"52.986375\", \"user_id\": 12, \"name\": \"Christina McArdle\", \"longitude\": \"-6.043701\"}"
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        self.sut = try decoder.decode(Customer.self, from: Data(jsonString.utf8))
                        expect(self.sut).to(beAKindOf(Customer.self))
                        expect(self.sut).toNot(beNil())
                        expect(self.sut.name).to(equal("Christina McArdle"))
                        expect(self.sut.userId).to(equal(12))
                        expect(self.sut.coordinates).to(beAKindOf(Coordinate.self))
                        expect(self.sut.coordinates?.latitude).to(equal(52.986375))
                        expect(self.sut.coordinates?.longitude).to(equal(-6.043701))
                    } catch {
                        fail("should not fail when instantiating")
                    }
                }
            }

            context("When instantiated from decoding a json with invalid latitude and longitude") {
                it("Should return a user with a nil coordinate") {
                    //swiftlint:disable line_length
                    let jsonString = "{\"latitude\": \"abc\", \"user_id\": 12, \"name\": \"Christina McArdle\", \"longitude\": \"72c\"}"
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        self.sut = try decoder.decode(Customer.self, from: Data(jsonString.utf8))
                        expect(self.sut).to(beAKindOf(Customer.self))
                        expect(self.sut).toNot(beNil())
                        expect(self.sut.name).to(equal("Christina McArdle"))
                        expect(self.sut.userId).to(equal(12))
                        expect(self.sut.coordinates).to(beNil())
                    } catch {
                        fail("should not fail when instantiating")
                    }
                }
            }
        }
    }
}
