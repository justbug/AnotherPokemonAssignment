//
//  Helper.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/14.
//

import Foundation
@testable import AnotherPokemonAssignment

enum Helper {
    static let dummyPath = "/dummyPath"
    static let dummyBaseURL = URL(string: "https://pokeapi.co")!
}

class MockStore: PokemonStore {
    var array: [LocalPokemon]

    init(array: [LocalPokemon] = []) {
        self.array = array
    }
    
    func savePokemons(_ pokemons: [LocalPokemon]) {
        array = pokemons
    }

    func getPokemons() -> [LocalPokemon] {
        array
    }
}
