//
//  RequestTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/13.
//

import Testing
@testable import AnotherPokemonAssignment

@Suite struct RequestTest {
    func test_request_init() throws {
        let sut = makeSUT(path: dummyPath)
        let request = try sut.makeToURLRequest()

        #expect(request.url?.absoluteString == "https://pokeapi.co\(dummyPath)")
        #expect(request.httpMethod == "GET")
    }


    func test_request_urlWithQuery() throws {
        let sut = makeSUT(path: dummyPath, query: [("q1", "v1"), ("q2", nil), ("q3", "v3")])
        let url = try sut.makeToURLRequest().url!
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let query = components.queryItems!
            .map { "\($0.name)=\($0.value!)" }
            .joined(separator: "&")
        #expect(query == "q1=v1&q3=v3")
    }
}

private extension RequestTest {
    func makeSUT(
        method: HTTPMethod = .get,
        path: String,
        query: QueryItems = nil
    ) -> Request {
        Request(baseURL: dummyBaseURL, method: method, path: path, query: query)
    }

    var dummyPath: String {
        Helper.dummyPath
    }

    var dummyBaseURL: URL {
        Helper.dummyBaseURL
    }
}
