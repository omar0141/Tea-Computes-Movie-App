//
//  MovieRepository.swift
//  movie-app
//
//  Created by Omar on 07/07/2025.
//

protocol MovieRepository {
    func getMovies() async -> [MovieModel]
}

class MovieRepositoryImpl: MovieRepository {
    
    private let remoteDataSource: MovieDataSource
    private let localDataSource: MovieDataSource

    
    init(remoteDataSource: MovieDataSource, localDataSource: MovieDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getMovies() async -> [MovieModel] {
        let movies: [MovieModel] = await remoteDataSource.getMovies()
        return movies
    }
}
