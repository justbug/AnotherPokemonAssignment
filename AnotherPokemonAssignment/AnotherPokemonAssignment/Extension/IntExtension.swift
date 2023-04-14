//
//  IntExtension.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/14.
//

import Foundation

extension Optional<Int> {
    var toString: String? {
        self.map(String.init)
    }
}
