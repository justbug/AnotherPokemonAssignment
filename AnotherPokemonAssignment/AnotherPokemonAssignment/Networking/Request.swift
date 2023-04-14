//
//  Request.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/13.
//

import Foundation

struct Request<Response> {
    let baseURL: URL = URL(string: "https://pokeapi.co")!
    let method: HTTPMethod
    let path: String
    let query: [(String, String?)]?
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
