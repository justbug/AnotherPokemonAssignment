//
//  PokemonStoreUseCaseTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/15.
//

import XCTest
@testable import AnotherPokemonAssignment

final class PokemonStoreUseCaseTest: XCTestCase {
    func test_pokemonStoreUseCase_init() async {
        let sut = makeSUT()
        let pokemon = await sut.getPokemon(id: dummyID)
        XCTAssertNil(pokemon?.id)
    }

    func test_pokemonStoreUseCase_setAndGetMethod() async {
        let otherID = "id2"
        let sut = makeSUT()
        await sut.savePokemon(name: dummyName, id: dummyID, isFavorite: true)
        await sut.savePokemon(name: dummyName, id: otherID, isFavorite: false)
        
        let pokemon = await sut.getPokemon(id: dummyID)
        XCTAssertEqual(pokemon?.isFavorite, true)
        XCTAssertEqual(pokemon?.name, dummyName)
    }

    func test_pokemonStoreUseCase_notFound_pokemon() async {
        let otherID = "id2"
        let sut = makeSUT()
        await sut.savePokemon(name: dummyName, id: dummyID, isFavorite: true)
        let pokemon = await sut.getPokemon(id: otherID)
        XCTAssertNil(pokemon?.id)
    }

    func test_pokemonStoreUseCase_update_pokemon_isFavorite() async {
        let sut = makeSUT()
        await sut.savePokemon(name: dummyName, id: dummyID, isFavorite: true)
        await sut.savePokemon(name: dummyName, id: dummyID, isFavorite: false)
        let pokemon = await sut.getPokemon(id: dummyID)
        XCTAssertEqual(pokemon?.isFavorite, false)
    }

}

private extension PokemonStoreUseCaseTest {
    func makeSUT() -> PokemonStoreUseCase {
        PokemonStoreUseCase(store: MockStore())
    }
}
