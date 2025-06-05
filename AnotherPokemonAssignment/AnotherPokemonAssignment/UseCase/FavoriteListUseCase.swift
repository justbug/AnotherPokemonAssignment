//
//  FavoriteListUseCase.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/17.
//

import Foundation

final class FavoriteListUseCase: ListUseCaseSpec {
    var shouldReloadWhenFavoriteUpdated: Bool = true

    private let store: PokemonStore
    private let limit = 30

    init(store: PokemonStore) {
        self.store = store
    }

    func fetchList(offset: Int) async throws -> [Pokemon] {
        getPokemons(limit: limit, offset: offset)
            .map { Pokemon(name: $0.name, id: $0.id) }
    }
}

private extension FavoriteListUseCase {
    private func getPokemons(limit: Int, offset: Int) -> [LocalPokemon] {
        let pokemons = store.getPokemons()
            .filter { $0.isFavorite }
        let endIndex = min(offset + limit, pokemons.count)
        if offset > endIndex { return [] }
        return Array(pokemons[offset..<endIndex])
    }
}
