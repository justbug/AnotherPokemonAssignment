//
//  PokemonStoreUseCase.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/15.
//

import Foundation

protocol PokemonStore {
    func savePokemons(_ pokemons: [LocalPokemon])
    func getPokemons() -> [LocalPokemon]
    func removePokemon(by id: String)
}

final class PokemonStoreUseCase {
    static let key = "PokemonStore"
    private let store: PokemonStore

    init(store: PokemonStore) {
        self.store = store
    }

    func savePokemon(name: String, id: String, isFavorite: Bool = false) {
        savePokemon(LocalPokemon(name: name, id: id, isFavorite: isFavorite))
    }

    func getPokemon(id: String) -> LocalPokemon? {
        store.getPokemons().first(where: { $0.id == id })
    }

    func removePokemon(by id: String) {
        store.removePokemon(by: id)
    }
}

extension Notification.Name {
    static let didFavorite: Notification.Name = .init(rawValue: "didFavorite")
}

private extension PokemonStoreUseCase {
    func savePokemon(_ pokemon: LocalPokemon) {
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
