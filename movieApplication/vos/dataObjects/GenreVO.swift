//
//  GenreVO.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 16/02/2022.
//

import Foundation

class GenreVO {
    var id : Int = 0
    var name : String = ""
    var isSelected : Bool = false
    
    init(id: Int,name:String,isSelected:Bool){
        self.name = name
        self.id = id
        self.isSelected = isSelected
    }
    
}
