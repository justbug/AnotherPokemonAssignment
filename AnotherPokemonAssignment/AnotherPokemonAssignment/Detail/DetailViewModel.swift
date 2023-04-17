//
//  DetailViewModel.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/17.
//

import Foundation

final class DetailViewModel {
    @Published var title: String? = nil
    @Published var detail: DetailModel? = nil
    let id: String
    let name: String
    private let useCase: DetailUseCase

    init(id: String, name: String, useCase: DetailUseCase) {
        self.id = id
        self.name = name
        self.useCase = useCase
        self.title = name
    }

    func fetchDetail() {
        Task {
            do {
                self.detail = try await useCase.fetchDetail()
            } catch {
                print(error)
            }
        }
    }
}
