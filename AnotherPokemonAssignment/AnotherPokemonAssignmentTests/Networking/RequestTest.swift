//
//  RequestTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/13.
//

import XCTest
@testable import AnotherPokemonAssignment

final class RequestTest: XCTestCase {
    func test_init() {
        let sut = makeSUT(path: dummyPath)
        XCTAssertEqual(sut.baseURL.absoluteString, "https://pokeapi.co")
        XCTAssertEqual(sut.method.rawValue, "GET")
    }
}

extension RequestTest {
    func makeSUT(
        method: HTTPMethod = .get,
        path: String,
        query: [(String, String?)]? = nil
    ) -> Request {
        Request(method: method, path: path, query: query)
    }

    var dummyPath: String {
        "/dummyPath"
    }
}
