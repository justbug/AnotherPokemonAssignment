//
//  PokemonStoreUseCase.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/15.
//

import Foundation

protocol PokemonStore {
    func savePokemons(_ pokemons: [StorePokemon])
    func getPokemons() -> [StorePokemon]
}

final class PokemonStoreUseCase {
    static let key = "PokemonStore"
    private let store: PokemonStore

    init(store: PokemonStore) {
        self.store = store
    }

    func savePokemon(name: String, id: String, isFavorite: Bool = false) {
        savePokemon(StorePokemon(name: name, id: id, isFavorite: isFavorite))
    }

    func getPokemon(id: String) -> StorePokemon? {
        store.getPokemons().first(where: { $0.id == id })
    }
}

private extension PokemonStoreUseCase {
    func savePokemon(_ pokemon: StorePokemon) {
        var pokemons = store.getPokemons()
        defer {
            store.savePokemons(pokemons)
        }
        guard let index = store.getPokemons().firstIndex(where: { $0.id == pokemon.id }) else {
            pokemons.append(pokemon)
            return
        }
        pokemons[index] = pokemon
    }
}