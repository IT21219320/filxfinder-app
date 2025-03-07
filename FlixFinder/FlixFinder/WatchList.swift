//
//  WatchList.swift
//  FlixFinder
//
//  Created by IM Student on 2025-03-07.
//

import Foundation
import SwiftData

@Model
final class WatchList {
    @Attribute(.unique)
    let id: Int
    let movie: Movie
    var watched: Bool
    
    init(id: Int, movie: Movie, watched: Bool = false) {
        self.id = id
        self.movie = movie
        self.watched = watched
    }
}
