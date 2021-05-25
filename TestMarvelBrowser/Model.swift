//
//  Model.swift
//  TestMarvelMonolithic
//
//  Created by David Vallejo on 24/5/21.
//

import Foundation

struct CharacterDataWrapper: Codable {
    let data: CharacterDataContainer
}

struct CharacterDataContainer: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let description: String
    let image: Image?
}

struct Image: Codable {
    let path: String
    let ext: String
    
    private enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
