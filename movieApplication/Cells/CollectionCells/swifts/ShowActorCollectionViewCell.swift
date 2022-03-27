//
//  ShowActorCollectionViewCell.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 25/03/2022.
//

import UIKit
import SDWebImage

class ShowActorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorImage: UIImageView!
    
    var data : MoreActorResult?{
        didSet{
            if let data = data {
                actorName.text = data.name
                let path = "\(imageBaseUrl)\(data.profilePath!)"
                
                actorImage.sd_setImage(with: URL(string: path))
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
