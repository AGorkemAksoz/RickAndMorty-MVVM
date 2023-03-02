//
//  RMCharacters.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 24.02.2023.
//

import Foundation


// MARK: - Characters
struct Characters: Codable {
    let results: [Results]?
}


// MARK: - Result
struct Results: Codable {
    let id: Int?
    let name, status, species, type: String?
    let gender: String?
    let origin, location: Location?
    let image: String?
    let url: String?
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}
