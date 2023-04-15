//
//  FavoriteViewModel.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/15.
//

import Foundation

final class FavoriteViewModel {
    private let useCase: PokemonStoreUseCase
    private(set) var id: String = ""
    private(set) var name: String = ""

    init(store: PokemonStore) {
        self.useCase = PokemonStoreUseCase(store: store)
    }

    func setIsFavorite(_ value: Bool) {
        useCase.savePokemon(name: name, id: id, isFavorite: value)
    }

    func getIsFavorite(id: String) -> Bool {
        useCase.getPokemon(id: id)?.isFavorite ?? false
    }

    func setID(_ id: String, name: String) {
        self.id = id
        self.name = name
    }
}
