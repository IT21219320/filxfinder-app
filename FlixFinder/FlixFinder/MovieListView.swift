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
                        HStack {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")) { image in
                                image.resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(width: 50, height: 75)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(movie.title)
                                .font(.headline)
                                .padding(.leading, 10)
                        }
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
            .onAppear {
                Task {
                    await fetchGenres()
                    await fetchMovies()
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func fetchGenres() async {
        let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZTNlY2U0ZGVlNmY0N2E2ZjJiYWNlOTY3ZGQwZmEwYSIsIm5iZiI6MTc0MTMyOTEyMS41ODYsInN1YiI6IjY3Y2E5MmUxZGJhMTQ5MTYwNjJiNDkxNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BWb1RzGZ3df3TuQ3IacGPsx3cb--XPLmy8f8bzQnJpw"
        ]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(GenreResponse.self, from: data)
            Genre.allGenres = decodedResponse.genres
        } catch {
            print("Failed to fetch genres: \(error)")
        }
    }

    private func fetchMovies() async {
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "include_video", value: "false"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZTNlY2U0ZGVlNmY0N2E2ZjJiYWNlOTY3ZGQwZmEwYSIsIm5iZiI6MTc0MTMyOTEyMS41ODYsInN1YiI6IjY3Y2E5MmUxZGJhMTQ5MTYwNjJiNDkxNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BWb1RzGZ3df3TuQ3IacGPsx3cb--XPLmy8f8bzQnJpw"
        ]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
            movies = decodedResponse.results.map { movie in
                var genres: [Genre] = []
                for genreId in movie.genre_ids {
                    if let genre = Genre.allGenres.first(where: { $0.id == genreId }) {
                        genres.append(genre)
                    }
                }
                return Movie(id: movie.id, title: movie.title, overview: movie.overview, poster_path: movie.poster_path, genre: genres)
            }
        } catch {
            print("Failed to fetch movies: \(error)")
        }
    }

}

#Preview {
    MovieListView()
}

