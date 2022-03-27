//
//  ShowTimeTableViewCell.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 16/02/2022.
//

import UIKit

class ShowTimeTableViewCell: UITableViewCell {
    @IBOutlet weak var showtimeView: UIView!
    
    @IBOutlet weak var seemoreLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        seemoreLabel.underlineText(text: "SEE MORE")
        //showtimeView.layer.cornerRadius = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
