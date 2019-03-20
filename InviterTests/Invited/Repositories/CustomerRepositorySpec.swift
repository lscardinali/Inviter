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

class StubLoader: CustomerLoadable {
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

    var sut: CustomerRepository!

    override func spec() {
        describe("The Customer Repository") {
            context("When loading Customers from a valid data source") {
                it("Should return data successfully") {
                    //swiftlint:disable line_length
                    let jsonString = "{\"latitude\": \"52.986375\", \"user_id\": 12, \"name\": \"Christina McArdle\", \"longitude\": \"-6.043701\"}\n {\"latitude\": \"51.92893\", \"user_id\": 1, \"name\": \"Alice Cahill\", \"longitude\": \"-10.27699\"}\n {\"latitude\": \"51.8856167\", \"user_id\": 2, \"name\": \"Ian McArdle\", \"longitude\": \"-10.4240951\"}\n"
                    let successStub = StubLoader(jsonString: jsonString)

                    self.sut = CustomerRepository(adapter: successStub)

                    self.sut.fetchCustomers { result in
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

                context("When loading Customers from an empty data source") {
                    it("Should return an empty array of customers") {
                        let jsonString = ""
                        let successStub = StubLoader(jsonString: jsonString)

                        self.sut = CustomerRepository(adapter: successStub)

                        self.sut.fetchCustomers { result in
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

                context("When loading Customers from an invalid data source") {
                    it("Should return an error") {
                        let jsonString = "{wrong json type},\n{should not\"parse\""
                        let successStub = StubLoader(jsonString: jsonString)

                        self.sut = CustomerRepository(adapter: successStub)

                        self.sut.fetchCustomers { result in
                            switch result {
                            case .success:
                                fail("Should fail when loading data")
                            case let .failure(error):
                                expect(error).to(beAKindOf(CustomerRepositoryError.self))
                                expect(error).to(equal(CustomerRepositoryError.parsingError))
                            }
                        }
                    }
                }
            }
        }
    }
}
