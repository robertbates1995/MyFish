//
//  Models.swift
//  MyFish
//
//  Created by Robert Bates on 9/21/23.
//

import Foundation

struct Fish: Equatable, Identifiable, Codable {
    var id: UUID
    var species: String
    var length: Double
    var weight: Double
    var notes: String
}

extension Fish {
    static let mock = Self(
        id: Fish.ID(),
        species: "Species",
        length: 1.0,
        weight: 1.0,
        notes: "This is an example of a note about a fish."
    )
}
