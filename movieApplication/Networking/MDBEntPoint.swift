//
//  MDBEntPoint.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 26/03/2022.
//

import Foundation
import Alamofire

enum MDBEndPoint : URLConvertible {
    
    case upcomingMovie(_ page: Int)
    case popularMovie(_ page: Int)
    case popularSerie
    case genreList
    case showcaseMovie(_ page: Int)
    case actorList(_ page: Int)
    case moreActor(_ page: Int)
    case movieDetail(_ id: Int)
    case serieDetail(_ id: Int)
    case movieCredit(_ id: Int)
    case similarMovie(_ id: Int)
    case movieTrailer(_ id: Int)
    case actorDetail(_ id: Int)
    case searchMovie(_ page: Int, query: String)
    case combinedCredit(_ id: Int)
    
    private var baseUrl : String{
        return baseURL
    }
    
    func asURL() throws -> URL {
        return url
    }
    
    var url : URL {
        let urlComponents = NSURLComponents(string: baseUrl.appending(apiPath))
        
        if(urlComponents?.queryItems == nil){
            urlComponents!.queryItems = []
        }
        urlComponents!.queryItems!.append(contentsOf: [URLQueryItem(name: "api_key", value: apikey)])
        return urlComponents!.url!
    }
    
    private var apiPath : String {
        switch self {
        case .upcomingMovie(let page):
            return "/movie/upcoming?page=\(page)"
        case .popularMovie(let page):
            return "/movie/popular?page=\(page)"
        case .popularSerie:
            return "/tv/popular?"
        case .genreList:
            return "/genre/movie/list?"
        case .showcaseMovie(let page):
            return "/movie/top_rated?page=\(page)"
        case .actorList(let page):
            return "/person/popular?page=\(page)"
        case .moreActor(let page):
            return "/person/popular?page=\(page)"
        case .movieDetail(let id):
            return "/movie/\(id)?"
        case .serieDetail(let id):
            return "/tv/\(id)?"
        case .movieCredit(let id):
            return "/movie/\(id)/credits?"
        case .similarMovie(let id):
            return "/movie/\(id)/similar?"
        case .movieTrailer(let id):
            return "/movie/\(id)/videos"
        case .actorDetail(let id):
            return "/person/\(id)"
        case .searchMovie(let page, let query):
            return "/search/movie?query=\(query)&page=\(page)"
        case .combinedCredit(let id):
            return "/person/\(id)/combined_credits"
        }
    }
}
