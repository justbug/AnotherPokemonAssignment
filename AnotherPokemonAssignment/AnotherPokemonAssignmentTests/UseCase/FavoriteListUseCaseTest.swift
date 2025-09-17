//
//  FavoriteListUseCaseTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/17.
//

import Testing
@testable import AnotherPokemonAssignment

@Suite struct FavoriteListUseCaseTest {
    func test_favoriteListUseCase_offset_startIndexIsZero() async throws {
        let sut = makeSUT(pokemons: dummyPokemons)
        let pokemons = try await sut.fetchList(offset: 0)
        #expect(pokemons.count == 3)
    }

    func test_favoriteListUseCase_offset_startIndexIsOne() async throws {
        let sut = makeSUT(pokemons: dummyPokemons)
        let pokemons = try await sut.fetchList(offset: 1)
        #expect(pokemons.count == 2)
    }

    func test_favoriteListUseCase_offset_startIndexAboveItemCount() async throws {
        let sut = makeSUT(pokemons: dummyPokemons)
        let pokemons = try await sut.fetchList(offset: 4)
        #expect(pokemons.isEmpty == true)
    }

    func test_favoriteListUseCase_emptyPokemons() async throws {
        let sut = makeSUT(pokemons: [])
        let pokemons = try await sut.fetchList(offset: 4)
        #expect(pokemons.isEmpty == true)
    }
}

private extension FavoriteListUseCaseTest {
    func makeSUT(pokemons: [LocalPokemon]) -> FavoriteListUseCase {
        FavoriteListUseCase(store: MockStore(array: pokemons))
    }

    var dummyPokemons: [LocalPokemon] {
        [
            .init(name: "a", id: "1", isFavorite: false),
            .init(name: "b", id: "2", isFavorite: true),
            .init(name: "c", id: "3", isFavorite: true),
            .init(name: "d", id: "4", isFavorite: true)
        ]
    }
}
