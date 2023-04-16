//
//  ListService.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/14.
//

import Foundation

protocol GetListSpec {
    func fetchList(limit: Int?, offset: Int?) async throws -> [Pokemon]
}

struct ListService: GetListSpec {
    private let path = "pokemon"

    func fetchList(limit: Int?, offset: Int?) async throws -> [Pokemon] {
        let entity: ListEntity = try await service.fetch(
            path: path,
            query: [("limit", limit.toString), ("offset", offset.toString)]
        )
        let pokemons = makeToModel(entity: entity)
        return pokemons
    }
}

private extension ListService {
    func makeToModel(entity: ListEntity) -> [Pokemon] {
        entity.results.compactMap({ entity in
            guard let id = getID(urlString: entity.url) else {
                return nil
            }
            return Pokemon(name: entity.name, id: id)
        })
    }

    func getID(urlString: String) -> String? {
        guard let url = URL(string: urlString), let intValue = Int(url.lastPathComponent) else {
            return nil
        }
        return String(intValue)
    }
}

struct ListEntity: Decodable {
    struct ResultEntity: Decodable {
        let name: String
        let url: String
    }
    let next: String?
    let results: [ResultEntity]
}
