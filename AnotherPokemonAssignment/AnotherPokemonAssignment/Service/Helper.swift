//
//  Helper.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/14.
//

import Foundation

protocol APIClientSpec {
    func fetch(request: Request) async throws -> Response
}

enum PokemonServiceError: Error {
    case invalidStatusCode
}

// MARK: - Response

extension Response {
    func validStatusCode() throws -> Response {
        guard let statusCode = self.statusCode, (200 ... 299).contains(statusCode) else {
            throw PokemonServiceError.invalidStatusCode
        }
        return self
    }
}

// MARK: - APIClientSpec

extension APIClient: APIClientSpec {}


