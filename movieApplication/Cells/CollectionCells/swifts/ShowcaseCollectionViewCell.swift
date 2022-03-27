//
//  ShowcaseCollectionViewCell.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 17/02/2022.
//

import UIKit

class ShowcaseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviename : UILabel!
    
    @IBOutlet weak var releaseDate : UILabel!
    
    @IBOutlet weak var backdrop : UIImageView!
    
    var data : MovieResult? {
        didSet{
            if let data = data {
                
                let titleText = data.originalTitle!
                let dateText = data.releaseDate
                let backdropPath = "\(imageBaseUrl)\(data.backdropPath ?? "")"
                
                moviename.text = titleText
                releaseDate.text = dateText
                backdrop.sd_setImage(with: URL(string: backdropPath))
                
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
