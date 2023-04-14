//
//  PokemonService.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/14.
//

import Foundation

private let client = APIClient()

final class PokemonService {
    private let apiClient: APIClientSpec
    private let decoder = JSONDecoder()
    private let requestMaker = PokemonRequestMaker()

    convenience init() {
        self.init(apiClient: client)
    }

    init(apiClient: APIClientSpec) {
        self.apiClient = apiClient
    }

    func fetch<T: Decodable>(path: String, query: [(String, String?)]?) async throws -> T {
        let request = requestMaker.makeRequest(path: path, query: query)
        let response = try await apiClient
            .fetch(request: request)
            .validStatusCode()
        return try decode(data: response.data)
    }
}

private extension PokemonService {
    func decode<T: Decodable>(data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}
