//
//  SliderTableViewCell.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 13/02/2022.
//

import UIKit

class SliderTableViewCell: UITableViewCell {
    
    weak var delegate: MovieItemDelegate?=nil

    @IBOutlet weak var collectionViewSlider: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var data : MovieListResponse? {
        didSet {
            if let data = data {
                pageControl.numberOfPages = data.results?.count ?? 0
                collectionViewSlider.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewSlider.dataSource = self
        collectionViewSlider.registerForCell(identifier: SliderCollectionViewCell.identifier)
        collectionViewSlider.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension SliderTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SliderCollectionViewCell.self), for: indexPath) as? SliderCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.data = data?.results?[indexPath.row]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 220.0)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x)/Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x)/Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data?.results?[indexPath.row]
        delegate?.onTapMovie(id: item?.id ?? 0)
    }
}
