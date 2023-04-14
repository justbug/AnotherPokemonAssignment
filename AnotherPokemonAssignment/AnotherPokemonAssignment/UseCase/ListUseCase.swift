//
//  ListUseCase.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/14.
//

import Foundation

final class ListUseCase {
    let listService: ListServiceSpec

    init(listService: ListServiceSpec) {
        self.listService = listService
    }

    private let limit = 30

    func fetchList(offset: Int) async throws -> [Pokemon] {
        let entity = try await listService.fetchList(limit: limit, offset: offset)
        let pokemons = makeToModel(entity: entity)
        return pokemons
    }
}

private extension ListUseCase {
    func makeToModel(entity: ListEntity) -> [Pokemon] {
        entity.results.compactMap({ entity in
            guard let id = getID(urlString: entity.url) else {
                return nil
            }
            return Pokemon(name: entity.name, id: id)
        })
    }

    func getID(urlString: String) -> Int? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        return Int(url.lastPathComponent)
    }
}

struct Pokemon {
    let name: String
    let id: Int
}
