//
//  ListUseCase.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/14.
//

import Foundation

final class ListUseCase {
    let listService: GetListSpec

    init(listService: GetListSpec) {
        self.listService = listService
    }

    private let limit = 30

    func fetchList(offset: Int) async throws -> [Pokemon] {
        try await listService.fetchList(limit: limit, offset: offset)
    }
}

struct Pokemon {
    let name: String
    let id: String
}

extension Pokemon: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
}
