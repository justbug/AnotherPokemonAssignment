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

    func test_listViewModel_fetchList() {
        let mock = ListServiceStub(data: listStubData)
        let sut = makeSUT(listService: mock)
        sut.$pokemons
            .filter { !$0.isEmpty }
            .receive(on: DispatchQueue.main)
            .sink { pokemons in
                XCTAssertEqual(pokemons.count, mock.getListEntity()?.results.count)
            }
            .store(in: &cancelBag)

        sut.fetchList()
    }
}

private extension ListViewModelTest {
    func makeSUT(listService: GetListSpec) -> ListViewModel {
        ListViewModel(title: "", listUseCase: ListUseCase(listService: listService))
    }
}
