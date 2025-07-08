//
//  MovieRepository.swift
//  movie-app
//
//  Created by Omar on 07/07/2025.
//

protocol MovieRepository {
    func getMovies() async -> [MovieModel]
    
    func saveMovies(_ movies: [MovieModel])
}

class MovieRepositoryImpl: MovieRepository {
    private let remoteDataSource: MovieRemoteDataSource
    private let localDataSource: MovieLocalDataSource

    init(
        remoteDataSource: MovieRemoteDataSource,
        localDataSource: MovieLocalDataSource
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func getMovies() async -> [MovieModel] {
        var movies: [MovieModel] = []
        movies = localDataSource.getMovies()
        if movies.isEmpty {
            movies = await remoteDataSource.getMovies()
            movies.sort { $0.voteAverage > $1.voteAverage }
            localDataSource.saveMovies(movies)
        }
        return movies
    }
    
    func saveMovies(_ movies: [MovieModel]) {
        localDataSource.saveMovies(movies)
    }
    
    
}
