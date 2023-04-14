//
//  RequestTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/13.
//

import XCTest
@testable import AnotherPokemonAssignment

final class RequestTest: XCTestCase {
    func test_init() throws {
        let sut = makeSUT(path: dummyPath)
        let request = try sut.makeToURLRequest()

        XCTAssertEqual(request.url?.absoluteString, "https://pokeapi.co\(dummyPath)")
        XCTAssertEqual(request.httpMethod, "GET")
    }


    func test_urlWithQuery() throws {
        let sut = makeSUT(path: dummyPath, query: [("q1", "v1"), ("q2", nil), ("q3", "v3")])
        let request = try sut.makeToURLRequest()
        XCTAssertEqual(request.url?.query(), "q1=v1&q3=v3")
    }
}

extension RequestTest {
    func makeSUT(
        method: HTTPMethod = .get,
        path: String,
        query: [(String, String?)]? = nil
    ) -> Request<Data> {
        Request(method: method, path: path, query: query)
    }

    var dummyPath: String {
        "/dummyPath"
    }
}
