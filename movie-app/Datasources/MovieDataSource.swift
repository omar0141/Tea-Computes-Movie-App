//
//  MovieDataSource.swift
//  movie-app
//
//  Created by Omar on 07/07/2025.
//

protocol MovieDataSource {
    func getMovies() async -> [MovieModel]
}
