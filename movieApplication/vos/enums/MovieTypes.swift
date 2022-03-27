//
//  MovieTypes.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 18/02/2022.
//

import Foundation

enum MovieType: Int {
    case MovieSlider = 0
    case PopularMovie = 1
    case PopularSerie = 2
    case ShowTime = 3
    case MovieGenre = 4
    case ShowCase = 5
    case BestActor = 6
}

enum ContentType: String{
    case contentMovie = "Movie"
    case contentSerie = "Serie"
    case contentActor = "Actor"
}
