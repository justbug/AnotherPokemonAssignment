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
    func getPokemons() -> [StorePokemon] {
        guard let data = userDefaults.data(forKey: Self.storePokemonKey) else { return [] }
        return (try? decoder.decode([StorePokemon].self, from: data)) ?? []
    }

    func savePokemons(_ pokemons: [StorePokemon]) {
        guard let data = try? encoder.encode(pokemons) else { return }
        userDefaults.set(data, forKey: Self.storePokemonKey)
    }
}

struct StorePokemon: Codable {
    let name: String
    let id: String
    let isFavorite: Bool
}
