//
//  PokemonRequestMakerTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/14.
//

import XCTest
@testable import AnotherPokemonAssignment

final class PokemonRequestMakerTest: XCTestCase {
    func testPokemonRequest() throws {
        let sut = makeSUT(path: "poke", query: [("q1", "v1")])
        let url = try sut.makeToURLRequest().url
        XCTAssertEqual(url?.absoluteString, "https://pokeapi.co/api/v2/poke?q1=v1")
    }
}

private extension PokemonRequestMakerTest {
    func makeSUT(path: String, query: [(String, String?)]?) -> Request {
        let maker = PokemonRequestMaker()
        return maker.makeRequest(path: path, query: query)
    }
}
