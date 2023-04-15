//
//  FavoriteViewModel.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/15.
//

import Foundation

final class FavoriteViewModel {
    private let useCase: FavoriteUseCase
    private(set) var id: String = ""

    init(store: FavoriteStore) {
        self.useCase = FavoriteUseCase(store: store)
    }

    func setIsFavorite(_ value: Bool, id: String) {
        useCase.setIsFavorite(value, id: id)
    }

    func getIsFavorite(id: String) -> Bool {
        useCase.getIsFavorite(id: id)
    }

    func setID(_ value: String) {
        id = value
    }
}
