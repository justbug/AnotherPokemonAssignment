//
//  ListUseCaseTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/14.
//

import XCTest
@testable import AnotherPokemonAssignment

final class ListUseCaseTest: XCTestCase {
    func test_validURL_result() async throws {
        let sut = makeSUT(entity: .init(next: nil, results: [ListEntity.ResultEntity(name: dummyName, url: dummyURL)]))
        let model = try await sut.fetchList(offset: 0)
        XCTAssertEqual(model.first?.name, dummyName)
        XCTAssertEqual(model.first?.id, dummyID)
    }

    func test_invalidURL_result() async throws {
        let sut = makeSUT(entity: .init(next: nil, results: [ListEntity.ResultEntity(name: dummyName, url: "https://pokeapi.co/d")]))
        let model = try await sut.fetchList(offset: 0)
        XCTAssertEqual(model.first?.name, nil)
        XCTAssertEqual(model.first?.id, nil)
    }
}

private extension ListUseCaseTest {
    func makeSUT(entity: ListEntity) -> ListUseCase {
        ListUseCase(listService: ListServiceStub(entity: entity))
    }

    var dummyName: String {
        "charizard"
    }

    var dummyURL: String {
        "https://pokeapi.co/api/v2/pokemon/\(dummyID)/"
    }

    var dummyID: Int {
        6
    }
}

struct ListServiceStub: ListServiceSpec {
    let entity: ListEntity

    func fetchList(limit: Int?, offset: Int?) async throws -> ListEntity {
        entity
    }
}
