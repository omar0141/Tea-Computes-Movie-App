//
//  MovieLocalDataSource.swift
//  movie-app
//
//  Created by Omar on 07/07/2025.
//

class MovieLocalDataSource {
    
    func getMovies() -> [MovieModel] {
        let movies: [MovieModel] = LocalHelper.shared.loadObject(key: "movies", type: [MovieModel].self) ?? []
        return movies
    }
    
    func saveMovies(_ movies: [MovieModel]) {
        LocalHelper.shared.saveObject(key: "movies", value: movies)
    }
    
}
