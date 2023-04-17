//
//  ListUseCaseTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/14.
//

import XCTest
@testable import AnotherPokemonAssignment

final class ListUseCaseTest: XCTestCase {
    func test_listUseCase_fetchList_result() async throws {
        let sut = makeSUT(pokemons: [.init(name: dummyName, id: dummyID)])
        let model = try await sut.fetchList(offset: 0)
        XCTAssertEqual(model.first?.name, dummyName)
        XCTAssertEqual(model.first?.id, dummyID)
    }

    func test_listUseCase_fetchList_empty_result() async throws {
        let sut = makeSUT(pokemons: [])
        let model = try await sut.fetchList(offset: 0)
        XCTAssertEqual(model.isEmpty, true)
    }
}

private extension ListUseCaseTest {
    func makeSUT(pokemons: [Pokemon]) -> ListUseCase {
        ListUseCase(listService: ListServiceStub(pokemons: pokemons))
    }
}

struct ListServiceStub: GetListSpec {
    let pokemons: [Pokemon]

    func fetchList(limit: Int?, offset: Int?) async throws -> [AnotherPokemonAssignment.Pokemon] {
        pokemons
    }
}
