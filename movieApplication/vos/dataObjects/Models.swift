//
//  Models.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 11/03/2022.
//


import Foundation

struct loginSuccess : Codable {
    var success : Bool?
    var statusCode : String?
    var statusMessage : String?
    
    enum CodingKeys : String, CodingKey {
        case success
        case statusCode = "expires_at"
        case statusMessage = "request_token"
    }
    
}

struct loginFailed : Codable {
    var success : Bool?
    var statusCode : Int?
    var statusMessage : String?
    
    enum CodingKeys : String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

struct loginRequest : Codable {
    var username : String?
    var password : String?
    var request_token : String?
}


//
//struct GenreList : Decodable {
//    let genres : [MovieGenre]
//}
//
//struct MovieGenre : Decodable{
//    let id : Int
//    let name : String
//}
//
//var movieGenre = [MovieGenre]()
