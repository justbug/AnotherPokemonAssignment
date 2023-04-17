//
//  ListViewModel.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/13.
//

import Combine
import Foundation

final class ListViewModel {
    @Published var title: String?
    @Published var pokemons: [Pokemon] = []
    private var offset = 0
    private let listUseCase: ListUseCaseSpec

    init(title: String, listUseCase: ListUseCaseSpec) {
        self.title = title
        self.listUseCase = listUseCase
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
