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

    func setIsFavorite(_ isFavorite: Bool) {
        if isFavorite {
            useCase.savePokemon(name: name, id: id, isFavorite: isFavorite)
        } else {
            useCase.removePokemon(by: id)
        }
        postNotification(isFavorite: isFavorite)
    }

    func getIsFavorite(id: String) -> Bool {
        useCase.getPokemon(id: id)?.isFavorite ?? false
    }

    func setID(_ id: String, name: String) {
        self.id = id
        self.name = name
    }

    func shouldUpdate(userInfo: FavoriteUserInfo, currentFavoriteState: Bool) -> Bool {
        if userInfo.id != id { return false }
        if userInfo.isFavorite == currentFavoriteState { return false }
        return true
    }
}

// MARK: - Helper

private extension FavoriteViewModel {
    func postNotification(isFavorite: Bool) {
        let userInfo = FavoriteUserInfo(id: id, isFavorite: isFavorite)
        NotificationCenter.default.post(name: .didFavorite, object: nil, userInfo: [FavoriteUserInfo.key: userInfo])
    }
}

struct FavoriteUserInfo {
    static let key = "FavoriteUserInfo"
    let id: String
    let isFavorite: Bool
}
