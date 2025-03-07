//
//  Movie.swift
//  FlixFinder
//
//  Created by IM Student on 2025-03-07.
//

import Foundation
import SwiftData

struct MovieResponse: Codable {
    let results: [MovieDTO]
}

struct MovieDTO: Codable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String
    let genre_ids: [Int]
}

@Model
final class Movie: Codable {
    @Attribute(.unique)
    let id: Int
    let title: String
    let overview: String
    let poster_path: String
    let genre: [Genre]
    
    init(id: Int, title: String, overview: String, poster_path: String, genre: [Genre]) {
        self.id = id
        self.title = title
        self.overview = overview
        self.poster_path = poster_path
        self.genre = genre
    }
}

extension Genre {
    static var allGenres: [Genre] = []
}
