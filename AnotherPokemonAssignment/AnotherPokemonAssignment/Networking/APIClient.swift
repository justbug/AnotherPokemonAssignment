//
//  APIClient.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/13.
//

import Foundation

final class APIClient {
    private let session = URLSession.shared

    func fetch(request: Request) async throws -> Response {
        let request = try request.makeToURLRequest()
        let (data, urlResponse) = try await data(urlRequest: request)
        return Response(response: urlResponse, data: data)
    }
}

private extension APIClient {
     func data(urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: urlRequest)
    }
}
