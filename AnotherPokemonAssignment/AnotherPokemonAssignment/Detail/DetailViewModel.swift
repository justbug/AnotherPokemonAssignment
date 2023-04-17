//
//  DetailViewModel.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/17.
//

import Foundation

final class DetailViewModel {
    @Published var detail: DetailModel? = nil
    private let id: String
    private let useCase: DetailUseCase

    init(id: String, useCase: DetailUseCase) {
        self.id = id
        self.useCase = useCase
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
