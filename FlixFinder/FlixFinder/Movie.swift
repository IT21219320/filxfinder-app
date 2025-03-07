//
//  Movie.swift
//  FlixFinder
//
//  Created by IM Student on 2025-03-07.
//

import Foundation
import SwiftData

@Model
final class Movie {
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
