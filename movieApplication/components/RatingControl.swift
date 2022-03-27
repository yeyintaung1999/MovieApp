//
//  RatingControl.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 15/02/2022.
//
import UIKit

@IBDesignable
class RatingControl: UIStackView {
    
    
    @IBInspectable var buttonsize : CGSize = CGSize(width: 10, height: 10){
        didSet{
            setupButtons()
            updateButtonRating()
        }
    }
    
    @IBInspectable var starcount : Int = 5 {
        didSet{
            setupButtons()
            updateButtonRating()
        }
    }
    
    @IBInspectable var rating : Int = 3 {
        didSet{
            updateButtonRating()
        }
    }
    
    @IBInspectable var ratingbuttons = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
        updateButtonRating()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
        updateButtonRating()
    }
    
    private func setupButtons(){
        
        clearExistingButtons()
        
        for _ in 0..<starcount{
            let button = UIButton()
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.setImage(UIImage(named: "selectstar"), for: .selected)
            button.setImage(UIImage(named: "emptystar"), for: .normal)
            
            button.heightAnchor.constraint(equalToConstant: buttonsize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: buttonsize.width).isActive = true
            
            addArrangedSubview(button)
            button.isUserInteractionEnabled=false
            
            ratingbuttons.append(button)
        }
        
    }
    
    private func updateButtonRating(){
        for (index,button) in ratingbuttons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    private func clearExistingButtons(){
        for button in ratingbuttons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingbuttons.removeAll()
    }
    
}

