// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let combinedListResponse = try? newJSONDecoder().decode(CombinedListResponse.self, from: jsonData)

import Foundation

// MARK: - CombinedListResponse
struct CombinedListResponse: Codable {
    let cast: [MovieResult]?
    let crew: [Crew]?
    let id: Int?
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: OriginalLanguage?
    let originalTitle, overview: String?
    let posterPath: String?
    let releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let popularity: Double?
    let character, creditID: String?
    let order: Int?
    let mediaType: MediaType?
    let name, originalName, firstAirDate: String?
    let originCountry: [String]?
    let episodeCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity, character
        case creditID = "credit_id"
        case order
        case mediaType = "media_type"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case episodeCount = "episode_count"
    }
}

//enum MediaType: String, Codable {
//    case movie = "movie"
//    case tv = "tv"
//}

//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case es = "es"
//}

// MARK: - Crew
struct Crew: Codable {
    let adult: Bool?
    let backdropPath: JSONNull3?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: OriginalLanguage?
    let originalTitle, overview: String?
    let posterPath: JSONNull3?
    let releaseDate, title: String?
    let video: Bool?
    let voteAverage, voteCount: Int?
    let popularity: Double?
    let creditID, department, job: String?
    let mediaType: MediaType?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
        case creditID = "credit_id"
        case department, job
        case mediaType = "media_type"
    }
}

// MARK: - Encode/decode helpers

class JSONNull3: Codable, Hashable {

    

    public static func == (lhs: JSONNull3, rhs: JSONNull3) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
