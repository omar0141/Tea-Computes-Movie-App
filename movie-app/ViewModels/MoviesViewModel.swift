//
//  MoviesViewModel.swift
//  movie-app
//
//  Created by Omar on 07/07/2025.
//

import Foundation

class MoviesViewModel {
    @Published var moviesList: [Any] = []

    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepositoryImpl) {
        self.movieRepository = movieRepository
    }

    func getMovies() async {
        moviesList = await movieRepository.getMovies()
    }

}
