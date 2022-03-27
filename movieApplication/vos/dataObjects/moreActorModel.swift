// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let actorMovieResponse = try? newJSONDecoder().decode(ActorMovieResponse.self, from: jsonData)

import Foundation

// MARK: - ActorMovieResponse
struct MoreActorResponse: Codable {
    let page: Int?
    let results: [ActorResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MoreActorResult: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownFor: [KnownFor]?
    let knownForDepartment: Department?
    let name: String?
    let popularity: Double?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownFor = "known_for"
        case knownForDepartment = "known_for_department"
        case name, popularity
        case profilePath = "profile_path"
    }
}

// MARK: - KnownFor
//struct KnownFor: Codable {
//    let adult: Bool?
//    let backdropPath: String?
//    let genreIDS: [Int]?
//    let id: Int?
//    let mediaType: MediaType?
//    let originalLanguage: OriginalLanguage?
//    let originalTitle, overview, posterPath, releaseDate: String?
//    let title: String?
//    let video: Bool?
//    let voteAverage: Double?
//    let voteCount: Int?
//    let firstAirDate, name: String?
//    let originCountry: [String]?
//    let originalName: String?
//
//    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
//        case genreIDS = "genre_ids"
//        case id
//        case mediaType = "media_type"
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview
//        case posterPath = "poster_path"
//        case releaseDate = "release_date"
//        case title, video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//        case firstAirDate = "first_air_date"
//        case name
//        case originCountry = "origin_country"
//        case originalName = "original_name"
//    }
//}
//
//enum MediaType: String, Codable {
//    case movie = "movie"
//    case tv = "tv"
//}
//
//enum OriginalLanguage: String, Codable {
//    case en = "en"
//}
//
//enum KnownForDepartment: String, Codable {
//    case acting = "Acting"
//}

