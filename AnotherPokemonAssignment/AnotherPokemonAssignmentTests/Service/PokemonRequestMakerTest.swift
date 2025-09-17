//
//  PokemonRequestMakerTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/14.
//

import Testing
@testable import AnotherPokemonAssignment

@Suite struct PokemonRequestMakerTest {
    func test_pokemonRequestMaker_PokemonRequest() throws {
        let sut = makeSUT(path: "poke", query: [("q1", "v1")])
        let url = try sut.makeToURLRequest().url
        #expect(url?.absoluteString == "https://pokeapi.co/api/v2/poke?q1=v1")
    }
}

private extension PokemonRequestMakerTest {
    func makeSUT(path: String, query: QueryItems) -> Request {
        let maker = PokemonRequestMaker()
        return maker.makeRequest(path: path, query: query)
    }
}
