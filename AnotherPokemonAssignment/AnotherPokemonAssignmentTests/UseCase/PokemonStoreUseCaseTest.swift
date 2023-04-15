//
//  PokemonStoreUseCaseTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/15.
//

import XCTest
@testable import AnotherPokemonAssignment

final class PokemonStoreUseCaseTest: XCTestCase {
    func test_init() {
        let sut = makeSUT()
        XCTAssertEqual(sut.getPokemon(id: dummyID)?.id, nil)
    }

    func test_setAndGetMethod() {
        let otherID = "id2"
        let sut = makeSUT()
        sut.savePokemon(name: dummyName, id: dummyID, isFavorite: true)
        sut.savePokemon(name: dummyName, id: otherID, isFavorite: false)
        
        XCTAssertEqual(sut.getPokemon(id: dummyID)!.isFavorite, true)
        XCTAssertEqual(sut.getPokemon(id: dummyID)!.name, dummyName)
    }

    func test_notFound_pokemon() {
        let otherID = "id2"
        let sut = makeSUT()
        sut.savePokemon(name: dummyName, id: dummyID, isFavorite: true)
        XCTAssertEqual(sut.getPokemon(id: otherID)?.id, nil)
    }

    func test_update_pokemon_isFavorite() {
        let sut = makeSUT()
        sut.savePokemon(name: dummyName, id: dummyID, isFavorite: true)
        sut.savePokemon(name: dummyName, id: dummyID, isFavorite: false)
        XCTAssertEqual(sut.getPokemon(id: dummyID)?.isFavorite, false)
    }

}

private extension PokemonStoreUseCaseTest {
    var dummyID: String {
        "id"
    }

    var dummyName: String {
        "name"
    }

    func makeSUT() -> PokemonStoreUseCase {
        PokemonStoreUseCase(store: MockStore())
    }

    class MockStore: PokemonStore {
        var array: [StorePokemon] = []

        func savePokemons(_ pokemons: [StorePokemon]) {
            array = pokemons
        }

        func getPokemons() -> [StorePokemon] {
            array
        }
    }
}
