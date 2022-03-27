//
//  SimilarMovieCollectionViewCell.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 23/03/2022.
//

import UIKit

class SimilarMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var name : UILabel!
    
    var data : MovieResult? {
        didSet{
            if data != nil {
                let backDropPath = "\(imageBaseUrl)\(data?.posterPath ?? "")"
                
                backImage.sd_setImage(with: URL(string: backDropPath))
                name.text = data?.originalTitle
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
