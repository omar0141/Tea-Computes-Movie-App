//
//  MovieRemoteDataSource.swift
//  movie-app
//
//  Created by Omar on 07/07/2025.
//

class MovieRemoteDataSource {
    
    func getMovies() async -> [MovieModel] {
        var movies: [MovieModel] = []
        let requestModel = HttpRequestModel(
            url: ApiEndPoints.movieNowPlaying,
            method: .get,
            headers: ["Authorization": "Bearer \(ApiEndPoints.apiKey)"],
            body: ["language": "en-US", "page": "1"],
        )
        do {
            let response: MovieNowPlayingResponseModel =
            try await HttpBase.shared.call(
                    requestModel,
                    contentType: .json,
                    responseType: MovieNowPlayingResponseModel.self
                )
            movies = response.results
            print(response.results.count)
        } catch {
            print("Request failed:", error.localizedDescription)
        }
        return movies
    }

}
