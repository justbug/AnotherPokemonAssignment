//
//  ListService.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/14.
//

import Foundation

protocol GetListSpec {
    func fetchList(limit: Int?, offset: Int?) async throws -> ListEntity
}

struct ListService: GetListSpec {
    private let path = "pokemon"

    func fetchList(limit: Int?, offset: Int?) async throws -> ListEntity {
        try await service.fetch(
            path: path,
            query: [("limit", limit.toString), ("offset", offset.toString)]
        )
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
