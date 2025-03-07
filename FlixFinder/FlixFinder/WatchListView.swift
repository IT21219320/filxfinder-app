//
//  WatchListView.swift
//  FlixFinder
//
//  Created by IM Student on 2025-03-07.
//

import SwiftUI
import SwiftData

struct WatchListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var watchList: [WatchList]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(watchList) { item in
                    NavigationLink {
                        Text("Item at \(item.movie.title)")
                    } label: {
                        Text(item.movie.title)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(watchList[index])
            }
        }
    }
}

#Preview {
    WatchListView()
        .modelContainer(for: WatchList.self, inMemory: true)
}
