//
//  SliderCollectionViewCell.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 13/02/2022.
//

import UIKit
import SDWebImage

class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sliderLabel : UILabel!
    @IBOutlet weak var sliderBackImage : UIImageView!
    
    var data : MovieResult? {
        didSet {
            if let data = data {
                let title = data.originalTitle
                let backdropImage = "\(imageBaseUrl)\(data.backdropPath!)"
                
                sliderLabel.text = title
                sliderBackImage.sd_setImage(with: URL(string: backdropImage))
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

}
