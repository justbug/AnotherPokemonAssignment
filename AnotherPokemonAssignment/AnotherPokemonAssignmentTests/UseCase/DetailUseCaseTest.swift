//
//  DetailUseCaseTest.swift
//  AnotherPokemonAssignmentTests
//
//  Created by Mark Chen on 2023/4/17.
//

import Testing
@testable import AnotherPokemonAssignment

@Suite struct DetailUseCaseTest {
    func test() async throws {
        let dummyWeight = 1
        let dummyHeight = 2
        let dummyType = "type"
        let sut = makeSUT(weight: dummyWeight, height: dummyHeight, type: dummyType)
        let model = try await sut.fetchDetail()
        #expect(String(model.id) == dummyID)
        #expect(model.weight == dummyWeight)
        #expect(model.height == dummyHeight)
        #expect(model.type == dummyType)
        #expect(model.idText == "id: \(dummyID)")
        #expect(model.weightText == "weight: \(dummyWeight)")
        #expect(model.heightText == "height: \(dummyHeight)")
        #expect(model.typeText == "type: \(dummyType)")
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
