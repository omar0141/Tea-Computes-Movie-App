//
//  MoviesViewModel.swift
//  movie-app
//
//  Created by Omar on 07/07/2025.
//

import Foundation

class MoviesViewModel {
    @Published var moviesList: [MovieModel] = []

    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepositoryImpl) {
        self.movieRepository = movieRepository
    }

    func getMovies() async {
        moviesList = await movieRepository.getMovies()
    }
    
    func toggleFavorite(movie: MovieModel) {
        let i: Int = moviesList.firstIndex(where: {$0.id == movie.id}) ?? -1
        if i > -1 {
            moviesList[i].isFavourite.toggle()
        }
        movieRepository.saveMovies(moviesList)
    }

}
