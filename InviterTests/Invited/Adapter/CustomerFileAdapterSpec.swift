//
//  CustomerFileAdapterSpec.swift
//  InviterTests
//
//  Created by lucas.cardinali on 3/20/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble
import Result

@testable import Inviter

class CustomerFileAdapterSpec: QuickSpec {

    var sut: CustomerFileAdapter!

    let bundle = Bundle(for: CustomerFileAdapterSpec.self)

    override func spec() {
        describe("The Customer File Adapter") {
            context("When loading data from a valid local file") {
                it("Should load successfully") {
                    self.sut = CustomerFileAdapter(bundle: self.bundle,
                                                   resourceName: "customer",
                                                   resourceExtension: "txt")
                    self.sut.fetchCustomerData { result in
                        switch result {
                        case let .success(value):
                            expect(value).toNot(beNil())
                            expect(value).to(beAKindOf(Data.self))
                        case .failure(_):
                             fail("Should not fail on loading this file")
                        }

                        print(result)

                    }

                }
            }

            context("When loading data from a Invalid local file") {
                it("Should load successfully") {
                    self.sut = CustomerFileAdapter(bundle: self.bundle, resourceName: "wrongfile", resourceExtension: "txt")
                    self.sut.fetchCustomerData { result in
//                        expect(result).to(be(Result<Data, CustomerLoadError>.Failure.self))
                        switch result {
                        case .success(_):
                            fail("Should return data when loading this file")
                        case let .failure(error):
                            expect(error).to(be(CustomerLoadError.unableToLoad))
                        }
                    }
                }
            }
        }
    }
}
