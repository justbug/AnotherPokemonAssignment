//
//  FavoriteListUseCaseTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/17.
//

import XCTest
@testable import AnotherPokemonAssignment

final class FavoriteListUseCaseTest: XCTestCase {
    func test_offset_startIndexIsZero() async throws {
        let sut = makeSUT(pokemons: dummyPokemons)
        let pokemons = try await sut.fetchList(offset: 0)
        XCTAssertEqual(pokemons.count, 3)
    }

    func test_offset_startIndexIsOne() async throws {
        let sut = makeSUT(pokemons: dummyPokemons)
        let pokemons = try await sut.fetchList(offset: 1)
        XCTAssertEqual(pokemons.count, 2)
    }

    func test_offset_startIndexAboveItemCount() async throws {
        let sut = makeSUT(pokemons: dummyPokemons)
        let pokemons = try await sut.fetchList(offset: 4)
        XCTAssertEqual(pokemons.isEmpty, true)
    }

    func test_emptyPokemons() async throws {
        let sut = makeSUT(pokemons: [])
        let pokemons = try await sut.fetchList(offset: 4)
        XCTAssertEqual(pokemons.isEmpty, true)
    }
}

private extension FavoriteListUseCaseTest {
    func makeSUT(pokemons: [LocalPokemon]) -> FavoriteListUseCase {
        FavoriteListUseCase(store: MockStore(array: pokemons))
    }

    var dummyPokemons: [LocalPokemon] {
        [
            .init(name: "a", id: "1", isFavorite: false),
            .init(name: "b", id: "2", isFavorite: false),
            .init(name: "c", id: "3", isFavorite: false)
        ]
    }
}
