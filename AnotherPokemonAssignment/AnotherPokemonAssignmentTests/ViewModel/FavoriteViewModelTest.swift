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

@MainActor
final class FavoriteViewModelTest: XCTestCase {
    func test_favoriteViewModel_storeIsEmpty() async {
        let mockStore = MockStore(array: [])
        let sut = await makeSUT(store: mockStore, id: dummyID, name: dummyName)
        XCTAssertEqual(sut.isFavorite, false)

        await sut.setIsFavorite(true)
        XCTAssertEqual(sut.isFavorite, true)
    }

    func test_favoriteViewModel_hadStoredIsFavorite() async {
        let mockStore = MockStore(array: [.init(name: dummyName, id: dummyID, isFavorite: true)])
        let sut = await makeSUT(store: mockStore, id: dummyID, name: dummyName)
        XCTAssertEqual(sut.isFavorite, true)

        await sut.setIsFavorite(false)
        XCTAssertEqual(sut.isFavorite, false)
    }

    func test_favoriteViewModel_emptyStore_notificationShouldUpdate() async {
        let mockStore = MockStore(array: [])
        let sut = await makeSUT(store: mockStore, id: dummyID, name: dummyName)
        sut.shouldUpdate(userInfo: .init(id: dummyID, isFavorite: true))
        XCTAssertEqual(sut.isFavorite, true)
    }


    func test_favoriteViewModel_notificationShouldUpdate() async {
        let mockStore = MockStore(array: [.init(name: dummyName, id: dummyID, isFavorite: false)])
        let sut = await makeSUT(store: mockStore, id: dummyID, name: dummyName)
        sut.shouldUpdate(userInfo: .init(id: dummyID, isFavorite: true))
        XCTAssertEqual(sut.isFavorite, true)
    }
}

private extension FavoriteViewModelTest {
    func makeSUT(store: PokemonStore, id: String, name: String) async -> FavoriteViewModel {
        let viewModel = FavoriteViewModel(store: store)
        viewModel.setID(id, name: name)
        await viewModel.reloadFavorite(id: id)
        return viewModel
    }
}
