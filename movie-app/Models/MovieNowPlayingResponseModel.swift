//
//  MovieNowPlayingResponseModel.swift
//  movie-app
//
//  Created by Omar on 07/07/2025.
//

import Foundation

// MARK: - MovieNowPlayingResponseModel
struct MovieNowPlayingResponseModel: Codable {
    let dates: DateModel
    let page: Int
    let results: [MovieModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct DateModel: Codable {
    let maximum, minimum: String
}

// MARK: - Result
struct MovieModel: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguageModel
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguageModel: String, Codable {
    case en = "en"
    case ko = "ko"
}
