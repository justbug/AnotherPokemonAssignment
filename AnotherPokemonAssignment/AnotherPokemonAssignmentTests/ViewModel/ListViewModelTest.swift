//
//  ListViewModelTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/14.
//

import Combine
import Foundation
import Testing
@testable import AnotherPokemonAssignment

@Suite struct ListViewModelTest {

    func test_listViewModel_fetchList() {
        var cancelBag = Set<AnyCancellable>()
        let mock = ListServiceStub(data: listStubData)
        let sut = makeSUT(listService: mock)
        sut.$pokemons
            .filter { !$0.isEmpty }
            .receive(on: DispatchQueue.main)
            .sink { pokemons in
                #expect(pokemons.count == mock.getListEntity()?.results.count)
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
