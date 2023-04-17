//
//  DetailService.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/17.
//

import Foundation

struct DetailService {
    private let id: String

    init(id: String) {
        self.id = id
    }

    func fetchDetail() async throws -> DetailModel {
        let entity: DetailEntity = try await service.fetch(
            path: "pokemon/\(id)",
            query: nil
        )
        return makeToModel(entity: entity)
    }
}

private extension DetailService {
    func makeToModel(entity: DetailEntity) -> DetailModel {
        let type = entity.types
            .map { $0.type.name }
            .joined(separator: ", ")
        let imageURLString = entity.sprites?.front_default ?? ""

        return DetailModel(
            id: entity.id,
            weight: entity.weight,
            height: entity.height,
            type: type,
            imageURL: URL(string: imageURLString)
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
