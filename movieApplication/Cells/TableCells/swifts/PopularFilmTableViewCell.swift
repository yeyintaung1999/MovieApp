//
//  PopularFilmTableViewCell.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 15/02/2022.
//

import UIKit

class PopularFilmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var popularText: UILabel!
    
    weak var delegate: MovieItemDelegate?=nil
    
    var data1 : MovieListResponse? {
        didSet{

            if let _ = data1 {popularCollectionCell.reloadData()}
        }
    }
    
    var data2 : MovieListResponse? {
        didSet{
            if let _ = data2 {popularCollectionCell.reloadData()}
        }
    }
    
    var titletext : String?
    
    @IBOutlet weak var popularCollectionCell: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        popularCollectionCell.dataSource=self
        popularCollectionCell.delegate = self
        popularCollectionCell.registerForCell(identifier: PopularFimlCollectionViewCell.identifier)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension PopularFilmTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if data1 == nil {
            return data2?.results?.count ?? 0
        } else {
            return data1?.results?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCells(identifier: PopularFimlCollectionViewCell.identifier, indexPath: indexPath) as? PopularFimlCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if data1 == nil {
            cell.data = data2?.results?[indexPath.row]
        } else {
            cell.data = data1?.results?[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if data1 == nil {
            let item = data2?.results?[indexPath.row]
            delegate?.onTapSerie(id: item?.id ?? 0)
        } else {
            let item = data1?.results?[indexPath.row]
            delegate?.onTapMovie(id: item?.id ?? 0)
        }
    }
}


