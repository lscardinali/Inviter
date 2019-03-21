//
//  CustomerRepositorySpec.swift
//  InviterTests
//
//  Created by lucas.cardinali on 3/20/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble
import Result

@testable import Inviter

class CustomerStubLoader: CustomerLoadable {
    init(jsonString: String) {
        self.jsonString = jsonString
    }

    let jsonString: String

    func fetchCustomerData(result: (Result<Data, CustomerLoadError>) -> Void) {
        let data = Data(jsonString.utf8)
        return result(.success(data))
    }
}

class CustomerRepositorySpec: QuickSpec {

    let hqCoordinates = Coordinate(latitude: 53.339428, longitude: -6.257664)

    var sut: CustomerRepository!

    //swiftlint:disable function_body_length
    override func spec() {
        describe("The Customer Repository") {
            context("When loading Customers from a valid data source") {
                //swiftlint:disable line_length
                let jsonString = "{\"latitude\": \"52.986375\", \"user_id\": 12, \"name\": \"Christina McArdle\", \"longitude\": \"-6.043701\"}\n {\"latitude\": \"51.92893\", \"user_id\": 1, \"name\": \"Alice Cahill\", \"longitude\": \"-10.27699\"}\n {\"latitude\": \"51.8856167\", \"user_id\": 2, \"name\": \"Ian McArdle\", \"longitude\": \"-10.4240951\"}\n"
                let successStub = CustomerStubLoader(jsonString: jsonString)

                self.sut = CustomerRepository(adapter: successStub)

                it("Should return data successfully") {
                    self.sut.fetchCustomers(within: 100, from: self.hqCoordinates, orderedById: false) { result in
                        switch result {
                        case let .success(values):
                            expect(values).to(beAKindOf([Customer].self))
                            expect(values.count).to(equal(1))
                            expect(values[0].name).to(equal("Christina McArdle"))
                            expect(values[0].userId).to(equal(12))
                        case .failure:
                            fail("Should not fail when loading data")
                        }
                    }
                }

                it("Should return more customers if the range is larger") {
                    self.sut.fetchCustomers(within: 1000, from: self.hqCoordinates, orderedById: false) { result in
                        switch result {
                        case let .success(values):
                            expect(values).to(beAKindOf([Customer].self))
                            expect(values.count).to(equal(3))
                            expect(values[0].name).to(equal("Christina McArdle"))
                            expect(values[0].userId).to(equal(12))
                            expect(values[2].name).to(equal("Ian McArdle"))
                            expect(values[2].userId).to(equal(2))
                        case .failure:
                            fail("Should not fail when loading data")
                        }
                    }
                }

                it("Should return customers in order") {
                    self.sut.fetchCustomers(within: 1000, from: self.hqCoordinates, orderedById: true) { result in
                        switch result {
                        case let .success(values):
                            expect(values).to(beAKindOf([Customer].self))
                            expect(values.count).to(equal(3))
                            expect(values[0].userId).to(equal(1))
                            expect(values[1].userId).to(equal(2))
                            expect(values[2].userId).to(equal(12))
                        case .failure:
                            fail("Should not fail when loading data")
                        }
                    }
                }

                context("When loading Customers from an empty data source") {
                    it("Should return an empty array of customers") {
                        let jsonString = ""
                        let successStub = CustomerStubLoader(jsonString: jsonString)

                        self.sut = CustomerRepository(adapter: successStub)

                        self.sut.fetchCustomers(within: 100, from: self.hqCoordinates, orderedById: true) { result in
                            switch result {
                            case let .success(values):
                                expect(values).to(beAKindOf([Customer].self))
                                expect(values).to(beEmpty())
                            case .failure:
                                fail("Should not fail when loading data")
                            }
                        }
                    }
                }
            }
        }
    }
}
