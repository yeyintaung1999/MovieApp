//
//  GenreCollectionViewCell.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 16/02/2022.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var genreName: UILabel!
    @IBOutlet weak var viewForOverlay: UIView!
    
    @IBOutlet weak var genreContainer: UIView!
    
//    var data : GenreResult? {
//        didSet{
//
//        }
//    }
    
    var tapItem : ((Int)->Void) = {_ in}
    
    
    
    var data : GenreVO? {
        didSet{
            genreName.text = data?.name.uppercased()
            
            (data?.isSelected ?? false) ? (viewForOverlay.isHidden=false) : (viewForOverlay.isHidden=true)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapItem))
        genreContainer.isUserInteractionEnabled = true
        genreContainer.addGestureRecognizer(tapGestureRecognizer)
        
    }
    @objc func didTapItem(){
        tapItem(data?.id ?? 0)
    }

}
