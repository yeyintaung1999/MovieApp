//
//  productionCompanyCollectionViewCell.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 23/03/2022.
//

import UIKit

class productionCompanyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var productionName: UILabel!
    
    var data1 : ProductionCompany? {
        didSet{
                bindProduction(data: data1!)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        
    }
  
    private func bindProduction(data : ProductionCompany){
        let backDropPath = "\(imageBaseUrl)\(data.logoPath ?? "")"
        self.backDropImage.sd_setImage(with: URL(string: backDropPath))
    }
    

}


