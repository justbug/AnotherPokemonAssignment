//
//  FavoriteUseCaseTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/15.
//

import XCTest
@testable import AnotherPokemonAssignment

final class FavoriteUseCaseTest: XCTestCase {
    func test_set_get_InsideStore() {
        let sut = makeSUT()
        sut.setIsFavorite(true, id: dummyID)
        XCTAssertEqual(sut.getIsFavorite(id: dummyID), true)
    }
}

private extension FavoriteUseCaseTest {
    var dummyID: String {
        "id"
    }

    func makeSUT() -> FavoriteUseCase {
        FavoriteUseCase(store: MockStore())
    }

    class MockStore: FavoriteStore {
        var dictionary: [String: Bool] = [:]

        func setIsFavorite(_ isFavorite: Bool, id: String) {
            dictionary[id] = isFavorite
        }

        func getIsFavorite(id: String) -> Bool {
            dictionary[id] ?? false
        }
    }
    
}
