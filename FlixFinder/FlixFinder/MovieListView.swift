//
//  MovieListView.swift
//  FlixFinder
//
//  Created by IM Student on 2025-03-07.
//

import SwiftUI

struct MovieListView: View {
    @State private var movies: [Movie] = []

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(movies) { movie in
                    NavigationLink {
                        Text("Item at \(movie.title)")
                    } label: {
                        Text(movie.title)
                    }
                }
            }
            .toolbar {
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
            }
        } detail: {
            Text("Select an item")
        }
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }

}

#Preview {
    MovieListView()
}

