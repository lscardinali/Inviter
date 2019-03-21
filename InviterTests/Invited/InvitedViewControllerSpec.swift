//
//  InvitedViewControllerSpec.swift
//  InviterTests
//
//  Created by Lucas Salton Cardinali on 21/03/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble
import SnapshotTesting

@testable import Inviter

class InvitedViewControllerSpec: QuickSpec {

    var sut: InvitedViewController!

    override func spec() {
        describe("The InheritedViewController") {
            context("When instantiated") {
                it("Should only show customers that are in range") {
                    //swiftlint:disable line_length
                    let loader = CustomerStubLoader(jsonString: "{\"latitude\": \"52.986375\", \"user_id\": 12, \"name\": \"Christina McArdle\", \"longitude\": \"-6.043701\"}\n{\"latitude\": \"51.92893\", \"user_id\": 1, \"name\": \"Alice Cahill\", \"longitude\": \"-10.27699\"}\n{\"latitude\": \"51.8856167\", \"user_id\": 2, \"name\": \"Ian McArdle\", \"longitude\": \"-10.4240951\"}\n{\"latitude\": \"52.3191841\", \"user_id\": 3, \"name\": \"Jack Enright\", \"longitude\": \"-8.5072391\"}\n{\"latitude\": \"53.807778\", \"user_id\": 28, \"name\": \"Charlie Halligan\", \"longitude\": \"-7.714444\"}\n{\"latitude\": \"53.1302756\", \"user_id\": 5, \"name\": \"Nora Dempsey\", \"longitude\": \"-6.2397222\"}")

                    let repository = CustomerRepository(adapter: loader)
                    self.sut = InvitedViewController(repository: repository)

                    assertSnapshot(matching: self.sut, as: .image)
                }

                it("show a message when no customers are in range") {
                    //swiftlint:disable line_length
                    let loader = CustomerStubLoader(jsonString: "{\"latitude\": \"52.833502\", \"user_id\": 25, \"name\": \"David Behan\", \"longitude\": \"-8.522366\"}\n")

                    let repository = CustomerRepository(adapter: loader)
                    self.sut = InvitedViewController(repository: repository)

                    assertSnapshot(matching: self.sut, as: .image)
                }

                it("Should show error when couldn't load data") {
                    let loader = CustomerStubLoader(jsonString: "{wrongjson}")

                    let repository = CustomerRepository(adapter: loader)
                    self.sut = InvitedViewController(repository: repository)

                    assertSnapshot(matching: self.sut, as: .image)
                }

            }
        }
    }
}
