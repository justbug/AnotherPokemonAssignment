//
//  DetailUseCaseTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/17.
//

import XCTest
@testable import AnotherPokemonAssignment

final class DetailUseCaseTest: XCTestCase {
    func test() async throws {
        let dummyWeight = 1
        let dummyHeight = 2
        let dummyType = "type"
        let sut = makeSUT(weight: dummyWeight, height: dummyHeight, type: dummyType)
        let model = try await sut.fetchDetail()
        XCTAssertEqual(String(model.id), dummyID)
        XCTAssertEqual(model.weight, dummyWeight)
        XCTAssertEqual(model.height, dummyHeight)
        XCTAssertEqual(model.type, dummyType)
        XCTAssertEqual(model.idText, "id: \(dummyID)")
        XCTAssertEqual(model.weightText, "weight: \(dummyWeight)")
        XCTAssertEqual(model.heightText, "height: \(dummyHeight)")
        XCTAssertEqual(model.typeText, "type: \(dummyType)")
    }
}

private extension DetailUseCaseTest {
    func makeSUT(weight: Int, height: Int, type: String) -> DetailUseCase {
        DetailUseCase(service: MockDetailService(weight: weight, height: height, type: type), id: dummyID)
    }
}

struct MockDetailService: DetailServiceSpec {
    private let decoder = JSONDecoder()
    let weight: Int
    let height: Int
    let type: String
    let imageURLString: String = "https://google.com"

    func fetchDetail(id: String) async throws -> DetailEntity {
        let id = Int(id)!
        let data = """
        {
            "id": \(id),
            "weight": \(weight),
            "height": \(height),
            "types": [
                {
                    "type": {
                        "name": "\(type)"
                    }
                }
            ],
            "sprites": {
                "front_default": "\(imageURLString)"
            }
        }
        """.data(using: .utf8)!
        return try decoder.decode(DetailEntity.self, from: data)
    }
}
