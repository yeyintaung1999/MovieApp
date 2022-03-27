//
//  networkingAgent.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 11/03/2022.
//

import Foundation
import Alamofire

protocol MovieDBNetworkAgentProtocol{
    func getUpcomingMovieList(page: Int,  completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getPopularMovieList(page: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getPopularSerieList( completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getGenreList( completion : @escaping (MDBResult<MovieGenre>) -> Void )
    func getShowCaseMovieList(page: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getActorList(page: Int, completion: @escaping (MDBResult<ActorListResponse>) -> Void)
    func getMoreActorList(page: Int, completion: @escaping (MDBResult<MoreActorResponse>)->Void)
    func getMovieDetail(id : Int, completion: @escaping (MDBResult<MovieDetailResponse>)->Void)
    func getSerieDetail(id : Int, completion: @escaping (MDBResult<MovieDetailResponse>)-> Void)
    func getMovieCredit(id : Int, completion: @escaping (MDBResult<MovieCreditResponse>)->Void)
    func getSimilarMovie(id : Int, completion: @escaping (MDBResult<SimilarMovieResponse>)->Void)
    func getMovieTrailer(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>)->Void)
    func getActorDetail(id:Int, completion: @escaping ( MDBResult<ActorDetailResponse> ) -> Void)
    func searchMovie(page: Int, query: String, completion: @escaping (MDBResult<MovieListResponse>)-> Void)
}



struct NetworkAgent : MovieDBNetworkAgentProtocol {
    static let shared = NetworkAgent()
    private init() {}
    
    func getUpcomingMovieList(page: Int = 1,  completion: @escaping (MDBResult<MovieListResponse>) -> Void){
        //let url = URL(string: "\(baseURL)/movie/upcoming?\(apiKey)")!
        AF.request(MDBEndPoint.upcomingMovie(page)).responseDecodable(of: MovieListResponse.self){ response in
            switch response.result {
            case .success(let upcomingMovieList):
                completion(.success(upcomingMovieList))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    func getPopularMovieList(page: Int=1, completion: @escaping (MDBResult<MovieListResponse>) -> Void){
        //let url = URL(string: "\(baseURL)/movie/popular?\(apiKey)")!
        AF.request(MDBEndPoint.popularMovie(page)).responseDecodable(of: MovieListResponse.self){ response in
            switch response.result {
            case .success(let movielistResponse):
                completion(.success(movielistResponse))
            case .failure(let error):
                completion(.failure(error.errorDescription!))
            }
        }
    }
    
    func getPopularSerieList( completion: @escaping (MDBResult<MovieListResponse>) -> Void){
        //let url = URL(string: "\(baseURL)/tv/popular?\(apiKey)")!
        AF.request(MDBEndPoint.popularSerie).responseDecodable(of: MovieListResponse.self){ response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error.errorDescription!))
            }
        }
    }
    func getGenreList( completion : @escaping (MDBResult<MovieGenre>) -> Void ) {
        //let url = URL(string: "\(baseURL)/genre/movie/list?\(apiKey)")!
        AF.request(MDBEndPoint.genreList).responseDecodable(of: MovieGenre.self){ response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error.errorDescription!))
            }
        }
    }
    
    func getShowCaseMovieList(page: Int=1, completion: @escaping (MDBResult<MovieListResponse>) -> Void){
        //let url = URL(string: "\(baseURL)/movie/top_rated?page=\(page)&\(apiKey)")!
        AF.request(MDBEndPoint.showcaseMovie(page)).responseDecodable(of: MovieListResponse.self){ response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error.errorDescription!))
            }
        }
    }
    
    func getActorList(page: Int, completion: @escaping (MDBResult<ActorListResponse>) -> Void){
        //let url = URL(string: "\(baseURL)/person/popular?\(apiKey)")!
        AF.request(MDBEndPoint.actorList(page)).responseDecodable(of: ActorListResponse.self){ response in
            switch response.result {
            case .success(let data):
                    completion(.success(data))
            case .failure(let error):
                completion(.failure(error.errorDescription!))
            }
        }
    }
    func getMoreActorList(page: Int, completion: @escaping (MDBResult<MoreActorResponse>)->Void){
        //let url = URL(string: "\(baseURL)/person/popular?page=\(page)&\(apiKey)")!
        AF.request(MDBEndPoint.moreActor(page)).responseDecodable(of: MoreActorResponse.self){ response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    
    
    func getMovieDetail(id : Int, completion: @escaping (MDBResult<MovieDetailResponse>)->Void){
        //let url = URL(string: "\(baseURL)/movie/\(id)?\(apiKey)")!
        AF.request(MDBEndPoint.movieDetail(id)).responseDecodable(of: MovieDetailResponse.self){ response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error.errorDescription!))
            }
        }
    }
    
    func getSerieDetail(id : Int, completion: @escaping (MDBResult<MovieDetailResponse>)-> Void){
        //let url = URL(string: "\(baseURL)/tv/\(id)?\(apiKey)")!
        AF.request(MDBEndPoint.serieDetail(id)).responseDecodable(of: MovieDetailResponse.self){ response in
            switch response.result {
            case .success(let data):
                    completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    func getMovieCredit(id : Int, completion: @escaping (MDBResult<MovieCreditResponse>)->Void){
       // let url = URL(string: "\(baseURL)/movie/\(id)/credits?\(apiKey)")!
        AF.request(MDBEndPoint.movieCredit(id)).responseDecodable(of: MovieCreditResponse.self){ response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    func getSimilarMovie(id : Int, completion: @escaping (MDBResult<SimilarMovieResponse>)->Void){
        //let url = URL(string: "\(baseURL)/movie/\(id)/similar?\(apiKey)")!
        AF.request(MDBEndPoint.similarMovie(id)).responseDecodable(of: SimilarMovieResponse.self){ response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error.errorDescription!))
            }
        }
    }
    
    func getMovieTrailer(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>)->Void){
        //let url = URL(string: "\(baseURL)/movie/\(id)/videos?\(apiKey)")!
        AF.request(MDBEndPoint.movieTrailer(id)).responseDecodable(of: MovieTrailerResponse.self){ response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error.errorDescription!))
            }
        }
    }
    
    func getActorDetail(id:Int, completion: @escaping ( MDBResult<ActorDetailResponse> ) -> Void) {
        //let url = URL(string: "\(baseURL)/person/\(id)?\(apiKey)")!
        AF.request(MDBEndPoint.actorDetail(id)).responseDecodable(of: ActorDetailResponse.self){ response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error.errorDescription!))
            }
        }
    }
    
    func searchMovie(page: Int, query: String, completion: @escaping (MDBResult<MovieListResponse>)-> Void){
        
        AF.request(MDBEndPoint.searchMovie(page, query: query)).responseDecodable(of: MovieListResponse.self){ response in
            switch response.result{
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
        
    }
    
    func getCombinedCredit(id:Int, completion: @escaping ( MDBResult<CombinedListResponse> ) -> Void) {
        //let url = URL(string: "\(baseURL)/person/\(id)?\(apiKey)")!
        AF.request(MDBEndPoint.combinedCredit(id)).responseDecodable(of: CombinedListResponse.self){ response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    
    
    
    
    
    /*
     
     Network Error - Different Scenarios
     
        *JSON Serialization Error
        *Wrong URL Error
        *Incorrect Methods
        *Missing Credentials
        *4xx
        *5xx
     
     */

    //Customize Error Body

    private func handleError<T, E: MDBErrorModel>(
        _ response : DataResponse<T, AFError>,
        _ error : (AFError),
        _ errorBodyType : E.Type
    ) -> String {
        var respBody : String = ""
        var serverErrorMessage : String?
        var errorBody : E?
        
        if let respData = response.data {
            respBody = String(data: respData, encoding: .utf8) ?? "Empty Response Body"
            
            errorBody = try? JSONDecoder().decode(errorBodyType, from: respData)
            serverErrorMessage = errorBody?.message
        }
        
        let respCode : Int = response.response?.statusCode ?? 0
        
        let sourcePath : String = response.response?.url?.absoluteString ?? "no url"
        
        
        //1 - Essential Debug Info
        print(
            """
            ==========================
            URL
            ->\(sourcePath)
            
            Status
            ->\(respCode)
            
            Body
            -> \(respBody)
            
            Underlying Error
            -> \(error.underlyingError!)
            
            Error Description
            -> \(error.errorDescription!)
            
            =========================
            
            """
            
        )
        
        return serverErrorMessage ?? error.errorDescription ?? "undefined"
        
        
    }
    
    
    
    
    
}

protocol MDBErrorModel : Decodable {
    var message : String { get }
}

class MDBCommonResponseError : MDBErrorModel {
    var message: String {
        return statusMessage
    }
    
    let statusMessage : String
    let statusCode : Int
    
    enum CodingKeys : String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}

enum MDBResult<T>{
    case success(T)
    case failure(String)
}


