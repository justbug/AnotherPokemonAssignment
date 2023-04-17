//
//  DetailUseCase.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/17.
//

import Foundation

final class DetailUseCase {
    private let service: DetailServiceSpec
    private let id: String

    init(service: DetailServiceSpec, id: String) {
        self.service = service
        self.id = id
    }

    func fetchDetail() async throws -> DetailModel {
        let entity = try await service.fetchDetail(id: id)
        return mapToModel(entity)
    }
}

private extension DetailUseCase {
    func mapToModel(_ entity: DetailEntity) -> DetailModel {
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
