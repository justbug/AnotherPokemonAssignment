//
//  ListUseCaseTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/14.
//

import XCTest
@testable import AnotherPokemonAssignment

final class ListUseCaseTest: XCTestCase {
    func test_listUseCase_fetchList_result() async throws {
        let sut = makeSUT(data: listStubData)
        let model = try await sut.fetchList(offset: 0)
        XCTAssertEqual(model.first?.name, dummyName)
        XCTAssertEqual(model.first?.id, dummyID)
    }

    func test_listUseCase_fetchList_empty_result() async throws {
        let data = """
        {
            "results": []
        }
        """.data(using: .utf8)!
        let sut = makeSUT(data: data)
        let model = try await sut.fetchList(offset: 0)
        XCTAssertEqual(model.isEmpty, true)
    }
}

private extension ListUseCaseTest {
    func makeSUT(data: Data) -> ListUseCase {
        ListUseCase(listService: ListServiceStub(data: data))
    }
}
