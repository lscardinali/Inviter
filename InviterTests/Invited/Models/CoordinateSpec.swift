//
//  CoordinateSpec.swift
//  InviterTests
//
//  Created by lucas.cardinali on 3/20/19.
//  Copyright © 2019 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble

@testable import Inviter

class CoordinateSpec: QuickSpec {

    var sut: Coordinate!

    override func spec() {
        describe("The Coordinate Model") {
            context("When instantiated") {
                it("Should return a valid Coordinate from Double") {
                    self.sut = Coordinate(latitude: 10.0, longitude: 12.0)
                    expect(self.sut.latitude).to(equal(10.0))
                    expect(self.sut.longitude).to(equal(12.0))
                }

                it("Should return a valid Coordinate from String") {
                    self.sut = Coordinate(latitude: "10.0", longitude: "12.0")
                    expect(self.sut.latitude).to(equal(10.0))
                    expect(self.sut.longitude).to(equal(12.0))
                }

                it("Should return a nil object from an invalid String") {
                    self.sut = Coordinate(latitude: "acb", longitude: "333zs")
                    expect(self.sut).to(beNil())
                }
            }

            context("When comparing distances") {
                it("Should return the correct distance in Kilometers between two Coordinates") {
                    self.sut = Coordinate(latitude: 53.339428, longitude: -6.257664)
                    let testCoordinate = Coordinate(latitude: 52.986375, longitude: -6.043701)
                    let distance = self.sut.distanceFrom(coordinate: testCoordinate)
                    expect(distance).to(equal(523))
                }

            }
        }
    }
}
