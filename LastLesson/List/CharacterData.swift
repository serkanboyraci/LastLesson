//
//  CharacterData.swift
//  LastLesson
//
//  Created by Ali serkan Boyracı  on 30.01.2023.
//

import Foundation

//

import Foundation

// MARK: - Character
struct ApiData: Codable {
    let results: [CharacterData]?
}

// MARK: - Result
struct CharacterData: Codable {
    let id: Int?
    let name, status, species, type: String?
    let gender: String?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}

