//
//  FavoriteListUseCase.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/17.
//

import Foundation

final class FavoriteListUseCase: ListUseCaseSpec {
    private let store: PokemonStore
    private let limit = 30

    init(store: PokemonStore) {
        self.store = store
    }


    func fetchList(offset: Int) async throws -> [Pokemon] {
        await withUnsafeContinuation { continuation in
            let pokemons = getPokemons(limit: limit, offset: offset).map { Pokemon(name: $0.name, id: $0.id) }
            continuation.resume(returning: pokemons)
        }
    }
}

private extension FavoriteListUseCase {
    private func getPokemons(limit: Int?, offset: Int?) -> [StorePokemon] {
        let pokemons = store.getPokemons()
        if pokemons.isEmpty { return [] }
        let limit = limit ?? 30
        let offset = offset ?? 0
        let endIndex = min(offset + limit, pokemons.count)
        return Array(pokemons[offset..<endIndex])
    }
}
