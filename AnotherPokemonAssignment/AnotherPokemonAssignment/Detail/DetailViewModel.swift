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
    private let service: DetailService

    init(id: String) {
        self.id = id
        self.service = .init(id: id)
    }

    func fetchDetail() {
        Task {
            do {
                self.detail = try await service.fetchDetail()
            } catch {
                print(error)
            }
        }
    }
}
