//
//  Request.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/13.
//

import Foundation

enum RequestError: Error {
    case initURLComponentsFailed
    case urlIsNil
}

typealias QueryItems = [(String, String?)]?

struct Request {
    private let baseURL: URL
    private let method: HTTPMethod
    private let path: String
    private let query: QueryItems
    private var fullURL: URL {
        var url = baseURL
        url.appendPathComponent(path)
        return url
    }
    
    init(baseURL: URL, method: HTTPMethod, path: String, query: QueryItems) {
        self.baseURL = baseURL
        self.method = method
        self.path = path
        self.query = query
    }

    func makeToURLRequest() throws -> URLRequest {
        guard var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: false) else {
            throw RequestError.initURLComponentsFailed
        }
        setQueryItems(to: &components)
        return try getURLRequest(url: components.url)
    }
}

private extension Request {
    func setQueryItems(to components: inout URLComponents) {
        guard let query = query, !query.isEmpty else { return }
        components.queryItems = query
            .filter({ tuple in
                if tuple.1 == nil {
                    return false
                }
                return true
            })
            .map(URLQueryItem.init)
    }

    func getURLRequest(url: URL?) throws -> URLRequest {
        guard let url = url else {
            throw RequestError.urlIsNil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}

struct HTTPMethod: RawRepresentable, ExpressibleByStringLiteral {
    let rawValue: String

    init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(stringLiteral value: String) {
        self.rawValue = value
    }

    static let get: HTTPMethod = "GET"
}
