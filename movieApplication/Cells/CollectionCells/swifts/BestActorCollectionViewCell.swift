//
//  BestActorCollectionViewCell.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 17/02/2022.
//

import UIKit
import SDWebImage

class BestActorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivHeart: UIImageView!
    @IBOutlet weak var ivHeartFill: UIImageView!
    
    @IBOutlet weak var actorImage : UIImageView!
    
    @IBOutlet weak var actorName : UILabel!
    
    @IBOutlet weak var knownFor : UILabel!
    
    var data : ActorResult? {
        didSet{
            if let _ = data {
                let name = data?.name ?? "Undefined"
                let knownFor = data?.knownForDepartment?.rawValue ?? "Unknown Department"
                let backdropPath = "\(imageBaseUrl)\(data?.profilePath ?? "")"
                
                actorImage.sd_setImage(with: URL(string: backdropPath))
                actorName.text = name
                self.knownFor.text = knownFor
            }
        }
    }
    
    
    weak var delegate:ActorActionDelegate?=nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initGestureRecognizer()
        
    }
    
    private func initGestureRecognizer(){
        let tapGestForFavorite = UITapGestureRecognizer(target: self, action: #selector(onTapFavorite))
        ivHeartFill.isUserInteractionEnabled = true
        ivHeartFill.addGestureRecognizer(tapGestForFavorite)
        
        let tapGestForUnFavorite = UITapGestureRecognizer(target: self, action: #selector(onTapUnfavorite))
        ivHeart.isUserInteractionEnabled = true
        ivHeart.addGestureRecognizer(tapGestForUnFavorite)
    }
    
    @objc func onTapFavorite(){
        ivHeart.isHidden = false
        ivHeartFill.isHidden = true
        delegate?.onTapFavorite(isFavorite: true)
    }
    
    @objc func onTapUnfavorite(){
        ivHeart.isHidden = true
        ivHeartFill.isHidden = false
        delegate?.onTapFavorite(isFavorite: false)
    }

}
