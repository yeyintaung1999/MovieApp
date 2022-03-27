//
//  ViewExtensions.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 17/02/2022.
//

import Foundation
import UIKit

extension UILabel {
    
    func underlineText(text: String){
        
        let attributedString = NSMutableAttributedString.init(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange(location: 0, length: attributedString.length))
        
        self.attributedText = attributedString
        
    }
    
}

extension UITableViewCell {
    static var identifier : String {
        String(describing: self)
    }
}

extension UITableView {
    func registerForCell(identifier:String){
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func dequeueCells<T:UITableViewCell>(identifier: String, indexPath: IndexPath)->T{
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            return UITableViewCell() as! T
        }
        return cell
    }
}

extension UICollectionViewCell {
    static var identifier : String {
        String(describing: self)
    }
}

extension UICollectionView {
    func registerForCell(identifier:String){
        register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueCells<T:UICollectionViewCell>(identifier: String, indexPath: IndexPath)->T{
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            return UICollectionViewCell() as! T
        }
        return cell
    }
}

extension UIViewController {
    static var identifier : String {
        String(describing: self)
    }
}


