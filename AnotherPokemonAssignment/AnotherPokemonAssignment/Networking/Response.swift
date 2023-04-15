//
//  Response.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/14.
//

import Foundation

struct Response {
    let response: URLResponse
    var statusCode: Int? { (response as? HTTPURLResponse)?.statusCode }
    let data: Data
}
