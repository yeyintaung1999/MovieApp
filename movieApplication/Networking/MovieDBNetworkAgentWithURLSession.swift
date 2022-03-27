//
//  MovieDBNetworkAgentWithURLSession.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 26/03/2022.
//

import Foundation

class MovieDBNetworkAgentWithURLSession : MovieDBNetworkAgentProtocol {
    
    let shared = MovieDBNetworkAgentWithURLSession()
    
    private init() { }
    
    func getUpcomingMovieList(page: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        
        let url = MDBEndPoint.upcomingMovie(page).url
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let urlSession = URLSession.shared
        urlSession.dataTask(with: urlRequest) { data, response, error in
            let movieResponse : MovieListResponse = try! JSONDecoder().decode(MovieListResponse.self, from: data!)
            
            print(movieResponse.results?.count ?? -1)
        }
        
    }
    
    func getPopularMovieList(page: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        
    }
    
    func getPopularSerieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        
    }
    
    func getGenreList(completion: @escaping (MDBResult<MovieGenre>) -> Void) {
        
    }
    
    func getShowCaseMovieList(page: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        
    }
    
    func getActorList(page: Int, completion: @escaping (MDBResult<ActorListResponse>) -> Void) {
        
    }
    
    func getMoreActorList(page: Int, completion: @escaping (MDBResult<MoreActorResponse>) -> Void) {
        
    }
    
    func getMovieDetail(id: Int, completion: @escaping (MDBResult<MovieDetailResponse>) -> Void) {
        
    }
    
    func getSerieDetail(id: Int, completion: @escaping (MDBResult<MovieDetailResponse>) -> Void) {
        
    }
    
    func getMovieCredit(id: Int, completion: @escaping (MDBResult<MovieCreditResponse>) -> Void) {
        
    }
    
    func getSimilarMovie(id: Int, completion: @escaping (MDBResult<SimilarMovieResponse>) -> Void) {
        
    }
    
    func getMovieTrailer(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void) {
        
    }
    
    func getActorDetail(id: Int, completion: @escaping (MDBResult<ActorDetailResponse>) -> Void) {
        
    }
    
    func searchMovie(page: Int, query: String, completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        
    }
    
    
}
