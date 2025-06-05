//
//  Helper.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/14.
//

import Foundation
import Testing
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

struct ListServiceStub: GetListSpec {
    let data: Data
    private let decoder = JSONDecoder()

    func fetchList(limit: Int?, offset: Int?) async throws -> ListEntity {
        try decoder.decode(ListEntity.self, from: data)
    }

    func getListEntity() -> ListEntity? {
        return try? decoder.decode(ListEntity.self, from: data)
    }
}

let dummyID = "1"

let dummyName = "a"

var listStubData: Data {
    """
    {
        "results": [
            {
                "name": "\(dummyName)",
                "url": "https://pokeapi.co/api/v2/ability/\(dummyID)/"
            }
        ]
    }
    """.data(using: .utf8)!
}
