//
//  ActorActionDelegate.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 18/02/2022.
//

import Foundation

protocol ActorActionDelegate : AnyObject{
    func onTapFavorite(isFavorite: Bool)
}
