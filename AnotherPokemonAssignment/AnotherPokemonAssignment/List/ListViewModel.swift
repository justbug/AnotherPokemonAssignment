//
//  ListViewModel.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/13.
//

import Combine
import Foundation

final class ListViewModel {
    @Published var title: String? = "List"
    @Published var pokemons: [Pokemon] = []
    private var offset = 0
    private let listUseCase: ListUseCase

    init(listService: GetListSpec) {
        self.listUseCase = ListUseCase(listService: listService)
    }

    func fetchList() {
        Task {
            do {
                let model = try await listUseCase.fetchList(offset: offset)
                offset = model.count
                pokemons.append(contentsOf: model)
            } catch {
                print(error)
            }
        }
    }
}
