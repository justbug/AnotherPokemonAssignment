//
//  UserDefaultsStore.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/16.
//

import Foundation

final class UserDefaultsStore {
    private let userDefaults = UserDefaults.standard
    private lazy var decoder = PropertyListDecoder()
    private lazy var encoder = PropertyListEncoder()
    static let storePokemonKey = "storePokemonKey"
}

extension UserDefaultsStore: PokemonStore {
    func removePokemon(by id: String) {
        var pokemons = getPokemons()
        guard let index = pokemons.firstIndex(where: { $0.id == id }) else { return }
        pokemons.remove(at: index)
        savePokemons(pokemons)
    }

    func getPokemons() -> [LocalPokemon] {
        guard let data = userDefaults.data(forKey: Self.storePokemonKey) else { return [] }
        return (try? decoder.decode([LocalPokemon].self, from: data)) ?? []
    }

    func savePokemons(_ pokemons: [LocalPokemon]) {
        guard let data = try? encoder.encode(pokemons) else { return }
        userDefaults.set(data, forKey: Self.storePokemonKey)
    }
}

struct LocalPokemon: Codable {
    let name: String
    let id: String
    let isFavorite: Bool
}
