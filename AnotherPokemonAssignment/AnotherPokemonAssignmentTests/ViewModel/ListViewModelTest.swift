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

    override func tearDown() {
        super.tearDown()
        cancelBag = []
    }

    func test_fetchList_withEntity() {
        let stub = EntityStub(pokemons: [.init(name: "butterfree", id: "12")])
        let sut = makeSUT(listService: stub)

        sut.$pokemons
            .filter { !$0.isEmpty }
            .receive(on: DispatchQueue.main)
            .sink { pokemons in
                XCTAssertEqual(pokemons.count, 1)
                XCTAssertEqual(stub.offset, 1)
            }
            .store(in: &cancelBag)

        sut.fetchList()
    }

    func test_pagination() {
        let stub = EntityStub(pokemons: [.init(name: "butterfree", id: "12")])
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
    func makeSUT(listService: GetListSpec) -> ListViewModel {
        ListViewModel(listService: listService)
    }
}

// MARK: - Stub

private extension ListViewModelTest {
    final class EntityStub: GetListSpec {
        let pokemons: [Pokemon]
        var offset: Int? = nil

        init(pokemons: [Pokemon]) {
            self.pokemons = pokemons
        }

        func fetchList(limit: Int?, offset: Int?) async throws -> [Pokemon] {
            self.offset = offset
            return pokemons
        }
    }
}
