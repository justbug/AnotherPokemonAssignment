//
//  Helper.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/14.
//

import Foundation
import XCTest
@testable import AnotherPokemonAssignment

enum Helper {
    static let dummyPath = "/dummyPath"
    static let dummyBaseURL = URL(string: "https://pokeapi.co")!
}

class MockStore: PokemonStore {
    func removePokemon(by id: String) {
        guard let index = array.firstIndex(where: { $0.id == id }) else { return }
        array.remove(at: index)
    }

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

extension XCTestCase {
    var dummyID: String {
        "1"
    }

    var dummyName: String {
        "a"
    }
}
