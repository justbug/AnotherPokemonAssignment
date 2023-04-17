//
//  DetailModel.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/17.
//

import Foundation

struct DetailModel {
    let id: Int
    let weight: Int
    let height: Int
    let type: String
    let imageURL: URL?
}

extension DetailModel {
    var idText: String {
        "id: \(String(id))"
    }

    var weightText: String {
        "weight: \(String(weight))"
    }

    var heightText: String {
        "height: \(String(height))"
    }

    var typeText: String {
        "type: \(type)"
    }

}
