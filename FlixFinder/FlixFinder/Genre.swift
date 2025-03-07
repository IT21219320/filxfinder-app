//
//  Genre.swift
//  FlixFinder
//
//  Created by IM Student on 2025-03-07.
//

import Foundation
import SwiftData

@Model
final class Genre {
    @Attribute(.unique) let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
