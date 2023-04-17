//
//  FavoriteViewModel.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/15.
//

import Foundation

final class FavoriteViewModel {
    @Published var isFavorite: Bool = false
    private let useCase: PokemonStoreUseCase
    private(set) var id: String = ""
    private(set) var name: String = ""

    init(store: PokemonStore) {
        self.useCase = PokemonStoreUseCase(store: store)
    }

    func setIsFavorite(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
        syncStore(isFavorite)
        postNotification(isFavorite: isFavorite)
    }

    func reloadFavorite(id: String) {
        let isFavorite = useCase.getPokemon(id: id)?.isFavorite ?? false
        self.isFavorite = isFavorite
    }

    func setID(_ id: String, name: String) {
        self.id = id
        self.name = name
    }

    func shouldUpdate(userInfo: FavoriteUserInfo) {
        if userInfo.id != id { return }
        if userInfo.isFavorite == isFavorite { return }
        isFavorite = userInfo.isFavorite
    }
}

// MARK: - Helper

private extension FavoriteViewModel {
    func postNotification(isFavorite: Bool) {
        let userInfo = FavoriteUserInfo(id: id, isFavorite: isFavorite)
        NotificationCenter.default.post(name: .didFavorite, object: nil, userInfo: [FavoriteUserInfo.key: userInfo])
    }

    func syncStore(_ isFavorite: Bool) {
        if isFavorite {
            useCase.savePokemon(name: name, id: id, isFavorite: isFavorite)
        } else {
            useCase.removePokemon(by: id)
        }
    }
}

struct FavoriteUserInfo {
    static let key = "FavoriteUserInfo"
    let id: String
    let isFavorite: Bool
}
