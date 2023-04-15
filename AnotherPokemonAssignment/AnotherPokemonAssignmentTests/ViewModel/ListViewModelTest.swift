//
//  ListViewModelTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/14.
//

import Combine
import Foundation
import XCTest
@testable import AnotherPokemonAssignment

final class ListViewModelTest: XCTestCase {
    private var cancelBag = Set<AnyCancellable>()

    func test_fetchList_withEntity() {
        let results: [ListEntity.ResultEntity] = [
            .init(name: "butterfree", url: "https://pokeapi.co/api/v2/pokemon/12/")
        ]
        let stub = EntityStub(entity: .init(next: nil, results: results))
        let sut = makeSUT(listService: stub)

        sut.$pokemons
            .filter { !$0.isEmpty }
            .sink { pokemons in
                XCTAssertEqual(pokemons.count, 1)
                XCTAssertEqual(stub.offset, 1)
            }
            .store(in: &cancelBag)

        sut.fetchList()
    }

    func test_pagination() {
        let results: [ListEntity.ResultEntity] = [
            .init(name: "butterfree", url: "https://pokeapi.co/api/v2/pokemon/12/")
        ]
        let stub = EntityStub(entity: .init(next: nil, results: results))
        let sut = makeSUT(listService: stub)
        var fetchCount = 0

        sut.$pokemons
            .filter { !$0.isEmpty }
            .receive(on: DispatchQueue.main)
            .sink { pokemons in
                fetchCount += 1
                XCTAssertEqual(pokemons.count, fetchCount)
                XCTAssertEqual(stub.offset, fetchCount)
            }
            .store(in: &cancelBag)

        sut.fetchList()
        sut.fetchList()
    }
}

private extension ListViewModelTest {
    func makeSUT(listService: ListServiceSpec) -> ListViewModel {
        ListViewModel(listService: listService)
    }
}

// MARK: - Stub

private extension ListViewModelTest {
    final class EntityStub: ListServiceSpec {
        let entity: ListEntity
        var offset: Int? = nil

        init(entity: ListEntity) {
            self.entity = entity
        }

        func fetchList(limit: Int?, offset: Int?) async throws -> ListEntity {
            self.offset = offset
            return entity
        }
    }
}
