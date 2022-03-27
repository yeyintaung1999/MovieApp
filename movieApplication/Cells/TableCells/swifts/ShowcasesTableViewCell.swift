//
//  ShowcasesTableViewCell.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 17/02/2022.
//

import UIKit

class ShowcasesTableViewCell: UITableViewCell {
    
    weak var delegate:MovieItemDelegate?=nil
    
    var showcaseDelegate : MoreShowCaseDelegate?=nil
    
    var data : MovieListResponse?
    
    @IBOutlet weak var showcasecollectionviewcell: UICollectionView!
    @IBOutlet weak var bestactorlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bestactorlbl.underlineText(text: "MORE SHOWCASES")
        
        showcasecollectionviewcell.dataSource = self
        showcasecollectionviewcell.delegate = self
        showcasecollectionviewcell.registerForCell(identifier: ShowcaseCollectionViewCell.identifier)
        
        initgesture()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initgesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        bestactorlbl.isUserInteractionEnabled = true
        bestactorlbl.addGestureRecognizer(gesture)
    }
    
    @objc func onTap(){
        print("MoreShowCase Clicked!")
        self.showcaseDelegate?.onTapMoreShowCase()
    }

}

extension ShowcasesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCells(identifier: ShowcaseCollectionViewCell.identifier, indexPath: indexPath) as ShowcaseCollectionViewCell
        
        cell.data = data?.results?[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width-20
        let height = (collectionView.frame.width/16)*9
        
        
        return CGSize(width: width , height: height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        (scrollView.subviews[(scrollView.subviews.count)-1]).subviews[0].backgroundColor = UIColor.yellow
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data?.results?[indexPath.row]
        delegate?.onTapMovie(id: item?.id ?? 0)
    }
    
}
