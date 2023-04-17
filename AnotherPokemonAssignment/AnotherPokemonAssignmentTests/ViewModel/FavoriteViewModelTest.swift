//
//  FavoriteViewModelTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/17.
//

import Combine
import Foundation
import XCTest
@testable import AnotherPokemonAssignment

final class FavoriteViewModelTest: XCTestCase {
    func test_favoriteViewModel_storeIsEmpty() {
        let mockStore = MockStore(array: [])
        let sut = makeSUT(store: mockStore, id: dummyID, name: dummyName)
        XCTAssertEqual(sut.getIsFavorite(id: dummyID), false)

        sut.setIsFavorite(true)
        XCTAssertEqual(sut.getIsFavorite(id: dummyID), true)
    }

    func test_favoriteViewModel_hadStoredIsFavorite() {
        let mockStore = MockStore(array: [.init(name: dummyName, id: dummyID, isFavorite: true)])
        let sut = makeSUT(store: mockStore, id: dummyID, name: dummyName)
        XCTAssertEqual(sut.getIsFavorite(id: dummyID), true)

        sut.setIsFavorite(false)
        XCTAssertEqual(sut.getIsFavorite(id: dummyID), false)
    }

    func test_favoriteViewModel_notificationShouldUpdate() {
        let mockStore = MockStore(array: [])
        let sut = makeSUT(store: mockStore, id: dummyID, name: dummyName)

        // state is same
        let result1 = sut.shouldUpdate(userInfo: .init(id: dummyID, isFavorite: true), currentFavoriteState: true)
        XCTAssertEqual(result1, false)

        let result2 = sut.shouldUpdate(userInfo: .init(id: dummyID, isFavorite: false), currentFavoriteState: false)
        XCTAssertEqual(result2, false)

        // state is diff
        let result3 = sut.shouldUpdate(userInfo: .init(id: dummyID, isFavorite: false), currentFavoriteState: true)
        XCTAssertEqual(result3, true)

        let result4 = sut.shouldUpdate(userInfo: .init(id: dummyID, isFavorite: true), currentFavoriteState: false)
        XCTAssertEqual(result4, true)
    }
}

private extension FavoriteViewModelTest {
    func makeSUT(store: PokemonStore, id: String, name: String) -> FavoriteViewModel {
        let viewModel = FavoriteViewModel(store: store)
        viewModel.setID(id, name: name)
        return viewModel
    }
}
