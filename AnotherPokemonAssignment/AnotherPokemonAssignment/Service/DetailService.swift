//
//  DetailService.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/17.
//

import Foundation

protocol DetailServiceSpec {
    func fetchDetail(id: String) async throws -> DetailEntity
}

struct DetailService: DetailServiceSpec {
    func fetchDetail(id: String) async throws -> DetailEntity {
        try await service.fetch(
            path: "pokemon/\(id)",
            query: nil
        )
    }
}

struct DetailEntity: Decodable {
    let id: Int
    let weight: Int
    let height: Int
    let types: [TypesEntity]
    let sprites: SpriteEntity?
}

struct TypesEntity: Decodable {
    struct TypeEntity: Decodable {
        let name: String
    }
    let type: TypeEntity
}

struct SpriteEntity: Decodable {
    let front_default: String?
}
