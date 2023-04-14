//
//  PokemonService.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/14.
//

import Foundation

private let client = APIClient()

final class PokemonService {
    struct Argument {
        let path: String
        let query: [(String, String?)]?
    }
    private let apiClient: APIClientSpec
    private let argument: Argument

    private let baseURL: URL = URL(string: "https://pokeapi.co")!
    private let decoder = JSONDecoder()
    private let apiVersion: String = "v2"

    convenience init(argument: Argument) {
        self.init(apiClient: client, argument: argument)
    }

    init(apiClient: APIClientSpec, argument: Argument) {
        self.apiClient = apiClient
        self.argument = argument
    }

    func fetch<T: Decodable>() async throws -> T {
        let request = makeRequest()
        let response = try await apiClient
            .fetch(request: request)
            .validStatusCode()
        return try decode(data: response.data)
    }
}

private extension PokemonService {
    func makeRequest() -> Request {
        Request(
            baseURL: baseURL,
            method: .get,
            path: "/api/\(apiVersion)/\(argument.path)",
            query: argument.query
        )
    }

    func decode<T: Decodable>(data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}
