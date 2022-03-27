//
//  MovieItemDelegate.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 18/02/2022.
//

import Foundation

protocol MovieItemDelegate : AnyObject{
    func onTapMovie(id : Int)
    func onTapSerie(id : Int)
}
