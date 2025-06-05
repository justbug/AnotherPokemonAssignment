//
//  FavoriteViewModelTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/17.
//

import Combine
import Foundation
import Testing
@testable import AnotherPokemonAssignment

@Suite struct FavoriteViewModelTest {
    func test_favoriteViewModel_storeIsEmpty() {
        let mockStore = MockStore(array: [])
        let sut = makeSUT(store: mockStore, id: dummyID, name: dummyName)
        #expect(sut.isFavorite == false)

        sut.setIsFavorite(true)
        #expect(sut.isFavorite == true)
    }

    func test_favoriteViewModel_hadStoredIsFavorite() {
        let mockStore = MockStore(array: [.init(name: dummyName, id: dummyID, isFavorite: true)])
        let sut = makeSUT(store: mockStore, id: dummyID, name: dummyName)
        #expect(sut.isFavorite == true)

        sut.setIsFavorite(false)
        #expect(sut.isFavorite == false)
    }

    func test_favoriteViewModel_emptyStore_notificationShouldUpdate() {
        let mockStore = MockStore(array: [])
        let sut = makeSUT(store: mockStore, id: dummyID, name: dummyName)
        sut.shouldUpdate(userInfo: .init(id: dummyID, isFavorite: true))
        #expect(sut.isFavorite == true)
    }


    func test_favoriteViewModel_notificationShouldUpdate() {
        let mockStore = MockStore(array: [.init(name: dummyName, id: dummyID, isFavorite: false)])
        let sut = makeSUT(store: mockStore, id: dummyID, name: dummyName)
        sut.shouldUpdate(userInfo: .init(id: dummyID, isFavorite: true))
        #expect(sut.isFavorite == true)
    }
}

private extension FavoriteViewModelTest {
    func makeSUT(store: PokemonStore, id: String, name: String) -> FavoriteViewModel {
        let viewModel = FavoriteViewModel(store: store)
        viewModel.setID(id, name: name)
        viewModel.reloadFavorite(id: id)
        return viewModel
    }
}
