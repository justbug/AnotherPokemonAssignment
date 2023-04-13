//
//  APIClient.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/13.
//

import Foundation

final class APIClient {
    private let session = URLSession.shared

    func data(urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: urlRequest)
    }
}
