//
//  Router.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 18/02/2022.
//

import Foundation
import UIKit

enum storyboardName : String {
    case Main = "Main"
    case LaunchScreen = "LaunchScreen"
}

extension UIStoryboard {
    static func mainStoryBoard()->UIStoryboard{
        UIStoryboard(name: storyboardName.Main.rawValue, bundle: nil)
    }
}

extension UIViewController {
    
    func navigateToMovieDetailViewController(serieId : Int){

        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.movieId = serieId
        vc.type = ContentType.contentSerie
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieDetailViewController(movieId : Int){

        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.movieId = movieId
        vc.type = ContentType.contentMovie
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieDetailViewController(actorId : Int){

        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.actorId = actorId
        vc.type = ContentType.contentActor
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToShowMoreActorViewController(data: MoreActorResponse){
        let vc = ShowMoreActorViewController()
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        vc.actorList=data
        self.navigationController?.pushViewController(vc, animated: true)
        //present(vc, animated: true, completion: nil)
    }
    
    func navigateToMoreShowCaseViewController(data: MovieListResponse){
        let vc = MoreShowCaseViewController()
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        vc.initdata=data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToSearchViewController(){
        let vc = SearchViewController()
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

