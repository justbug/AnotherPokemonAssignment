//
//  PokemonServiceTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/14.
//

import XCTest
@testable import AnotherPokemonAssignment

final class PokemonServiceTest: XCTestCase {
    func test_successEntityStub() async throws {
        let sut = makeSUT(stub: SuccessStub())
        let entity: SuccessEntity = try await sut.fetch(path: Helper.dummyPath, query: nil)
        XCTAssertEqual(entity.foo, "bar")
    }

    func test_errorStub500_shouldThrowInvalidStatusCodeError() {
        Task {
            do {
                let sut = makeSUT(stub: ErrorStub())
                let _: SuccessEntity = try await sut.fetch(path: Helper.dummyPath, query: nil)
                XCTFail("should throw error")
            } catch {
                XCTAssertEqual(error as! PokemonServiceError, PokemonServiceError.invalidStatusCode)
            }
        }
    }
}

private extension PokemonServiceTest {
    func makeSUT(stub: APIClientSpec) -> PokemonService {
        PokemonService(apiClient: stub)
    }

    var dummyRequest: Request {
        PokemonRequestMaker().makeRequest(path: Helper.dummyPath, query: nil)
    }
}

// MARK: - Stub

private extension PokemonServiceTest {
    final class SuccessStub: APIClientSpec {
        let data = """
        {
            "foo": "bar"
        }
        """.data(using: .utf8)!

        func fetch(request: Request) async throws -> Response {
            let httpResponse = HTTPURLResponse(
                url: try request.makeToURLRequest().url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return Response(response: httpResponse, data: data)
        }
    }

    struct SuccessEntity: Decodable {
        let foo: String
    }

    final class ErrorStub: APIClientSpec {
        let data = "Some Error String".data(using: .utf8)!

        func fetch(request: Request) async throws -> Response {
            let httpResponse = HTTPURLResponse(
                url: try request.makeToURLRequest().url!,
                statusCode: 500,
                httpVersion: nil,
                headerFields: nil
            )!
            return Response(response: httpResponse, data: data)
        }
    }
}
