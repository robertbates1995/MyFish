//
//  MyFishTests.swift
//  MyFishTests
//
//  Created by Robert Bates on 9/26/23.
//

import ComposableArchitecture
import XCTest
@testable import MyFish

final class MyFishTests: XCTestCase {
    func testAddDeleteFish() {
        let store = TestStore(
            initialState: FishFormFeature.State(
                fish: Fish(id: UUID())
            )
        ) {
            FishFormFeature()
        }
        //await store.send(.addFishButtonPressed)
    }
}
