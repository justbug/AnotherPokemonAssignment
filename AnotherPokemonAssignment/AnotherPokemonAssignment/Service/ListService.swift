//
//  ListService.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/14.
//

import Foundation

struct ListService {
    private let path = "pokemon"

    func fetchList(limit: Int?, offset: Int?) async throws -> ListEntity {
        let entity: ListEntity = try await service.fetch(
            path: path,
            query: [("limit", limit.toString), ("offset", offset.toString)]
        )
        return entity
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
