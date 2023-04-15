//
//  FavoriteUseCase.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/15.
//

import Foundation

protocol FavoriteStore {
    func setIsFavorite(_ isFavorite: Bool, id: String)
    func getIsFavorite(id: String) -> Bool
}

final class FavoriteUseCase {
    static let key = "PokemonFavorite"
    private let store: FavoriteStore

    init(store: FavoriteStore) {
        self.store = store
    }

    func setIsFavorite(_ isFavorite: Bool, id: String) {
        store.setIsFavorite(isFavorite, id: id)
    }

    func getIsFavorite(id: String) -> Bool {
        store.getIsFavorite(id: id)
    }
}

extension UserDefaults: FavoriteStore {
    func setIsFavorite(_ isFavorite: Bool, id: String) {
        var dic = getFavoriteDictionary()
        dic[id] = isFavorite
        setValue(dic, forKey: FavoriteUseCase.key)
    }

    func getIsFavorite(id: String) -> Bool {
        let dic = getFavoriteDictionary()
        return dic[id] ?? false
    }

    private func getFavoriteDictionary() -> [String: Bool] {
        (object(forKey: FavoriteUseCase.key) as? [String: Bool]) ?? [:]
    }
}
