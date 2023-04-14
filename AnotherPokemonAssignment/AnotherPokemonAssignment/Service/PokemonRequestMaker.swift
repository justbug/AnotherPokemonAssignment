//
//  PokemonRequestMaker.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/14.
//

import Foundation

struct PokemonRequestMaker {
    private let baseURL = URL(string: "https://pokeapi.co")!
    private let apiVersion: String = "v2"

    func makeRequest(path: String, query: [(String, String?)]?) -> Request {
        Request(
            baseURL: baseURL,
            method: .get,
            path: "/api/\(apiVersion)/\(path)",
            query: query
        )
    }
}
