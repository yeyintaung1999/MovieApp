//
//  MovieModel.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 26/03/2022.
//

import Foundation

protocol MovieModel {
    func getUpcomingMovieList(page: Int,  completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getPopularMovieList(page: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getPopularSerieList( completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getGenreList( completion : @escaping (MDBResult<MovieGenre>) -> Void )
    func getShowCaseMovieList(page: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getActorList(page: Int, completion: @escaping (MDBResult<ActorListResponse>) -> Void)
    func getMoreActorList(page: Int, completion: @escaping (MDBResult<MoreActorResponse>)->Void)
}

class MovieModelImpl: BaseModel, MovieModel {
    
    static let shared = MovieModelImpl()
    
    private override init() { }

    func getUpcomingMovieList(page: Int,  completion: @escaping (MDBResult<MovieListResponse>) -> Void){
        networkAgent.getUpcomingMovieList(page: page, completion: completion)
    }
    
    func getPopularMovieList(page: Int=1, completion: @escaping (MDBResult<MovieListResponse>) -> Void){
        networkAgent.getPopularMovieList(page: page, completion: completion)
    }
    
    func getPopularSerieList( completion: @escaping (MDBResult<MovieListResponse>) -> Void){
        networkAgent.getPopularSerieList(completion: completion)
    }
    
    func getGenreList( completion : @escaping (MDBResult<MovieGenre>) -> Void ){
        networkAgent.getGenreList(completion: completion)
    }
    func getShowCaseMovieList(page: Int=1, completion: @escaping (MDBResult<MovieListResponse>) -> Void){
        networkAgent.getShowCaseMovieList(page: page, completion: completion)
    }
    
    func getActorList(page: Int, completion: @escaping (MDBResult<ActorListResponse>) -> Void){
        networkAgent.getActorList(page: page, completion: completion)
    }
    
    
    func getMoreActorList(page: Int, completion: @escaping (MDBResult<MoreActorResponse>)->Void){
        networkAgent.getMoreActorList(page: page, completion: completion)
    }
    
}
