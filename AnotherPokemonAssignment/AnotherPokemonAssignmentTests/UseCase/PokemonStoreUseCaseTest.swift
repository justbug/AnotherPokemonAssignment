//
//  PokemonStoreUseCaseTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/15.
//

import Testing
@testable import AnotherPokemonAssignment

@Suite struct PokemonStoreUseCaseTest {
    func test_pokemonStoreUseCase_init() {
        let sut = makeSUT()
        #expect(sut.getPokemon(id: dummyID)?.id == nil)
    }

    func test_pokemonStoreUseCase_setAndGetMethod() {
        let otherID = "id2"
        let sut = makeSUT()
        sut.savePokemon(name: dummyName, id: dummyID, isFavorite: true)
        sut.savePokemon(name: dummyName, id: otherID, isFavorite: false)
        
        #expect(sut.getPokemon(id: dummyID)!.isFavorite == true)
        #expect(sut.getPokemon(id: dummyID)!.name == dummyName)
    }

    func test_pokemonStoreUseCase_notFound_pokemon() {
        let otherID = "id2"
        let sut = makeSUT()
        sut.savePokemon(name: dummyName, id: dummyID, isFavorite: true)
        #expect(sut.getPokemon(id: otherID)?.id == nil)
    }

    func test_pokemonStoreUseCase_update_pokemon_isFavorite() {
        let sut = makeSUT()
        sut.savePokemon(name: dummyName, id: dummyID, isFavorite: true)
        sut.savePokemon(name: dummyName, id: dummyID, isFavorite: false)
        #expect(sut.getPokemon(id: dummyID)?.isFavorite == false)
    }

}

private extension PokemonStoreUseCaseTest {
    func makeSUT() -> PokemonStoreUseCase {
        PokemonStoreUseCase(store: MockStore())
    }
}
