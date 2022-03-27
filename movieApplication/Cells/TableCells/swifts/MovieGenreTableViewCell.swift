//
//  MovieGenreTableViewCell.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 16/02/2022.
//

import UIKit
import Alamofire

class MovieGenreTableViewCell: UITableViewCell {
    
    var movieListByGnenre : [Int:Set<MovieResult>] = [:]
    
    weak var delegate : MovieItemDelegate?=nil
    
    var selectedMovieList : [MovieResult] = [] {
        didSet{
            genreMovieCells.reloadData()
        }
    }
    
    var allMovieAndSeries : [MovieResult] = []{
        didSet{
            
            allMovieAndSeries.forEach{ movieSeries in
                movieSeries.genreIDS?.forEach({ genreid in
                    let key = genreid

                    
                    if var _ = movieListByGnenre[key]{
                        movieListByGnenre[key]!.insert(movieSeries)
                    } else {
                        movieListByGnenre[key] = [movieSeries]
                    }
                    
                })
            }
        
            genreCollectionCell.reloadData()
            genreMovieCells.reloadData()
            
            onTapGenre(genreid: greneList?[0].id ?? 0)
            
        }
    }
 
    var greneList : [GenreVO]? {
        didSet{
                if var data = greneList {
                    data.removeAll(where: { genreVO in
                        let genreID = genreVO.id
                        let result = movieListByGnenre.filter{ key,value -> Bool in
                            key == genreID
                        }
                        return result.count == 0
                    })
                    self.genreCollectionCell.reloadData()
                    self.genreMovieCells.reloadData()
                }
        }
    }
    
    @IBOutlet weak var genreCollectionCell: UICollectionView!
    
    @IBOutlet weak var genreMovieCells: UICollectionView!

    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        genreCollectionCell.dataSource=self
        genreCollectionCell.register(UINib(nibName: String(describing: GenreCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: GenreCollectionViewCell.self))
        genreCollectionCell.delegate = self
        
        genreMovieCells.dataSource=self
        genreMovieCells.register(UINib(nibName: String(describing: PopularFimlCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PopularFimlCollectionViewCell.self))
        genreMovieCells.delegate = self
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.genreMovieCells.reloadData()
        
        // Configure the view for the selected state
    }
    
}

extension MovieGenreTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == genreMovieCells {
            return selectedMovieList.count
        } else {
            return greneList?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == genreMovieCells {
            let cell = collectionView.dequeueCells(identifier: PopularFimlCollectionViewCell.identifier, indexPath: indexPath) as PopularFimlCollectionViewCell
            
            cell.data = selectedMovieList[indexPath.row]
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GenreCollectionViewCell.self), for: indexPath) as? GenreCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.data = greneList?[indexPath.row]
            

            cell.tapItem = { genreid in
                //                self.genreMovieCells.reloadData()
                self.onTapGenre(genreid: genreid)
            }
            return cell
        }
    }
    
    private func onTapGenre(genreid: Int){
        self.greneList?.forEach { (GenreVO) in
            if genreid == GenreVO.id {
                GenreVO.isSelected=true
            }
            else {
                GenreVO.isSelected=false
            }
        }
        let movieList1 = self.movieListByGnenre[genreid]
        self.selectedMovieList = movieList1?.map{ $0 } ?? [MovieResult]()
        
        self.genreCollectionCell.reloadData()
        self.genreMovieCells.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == genreMovieCells {
            return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height)
        } else {
            return CGSize(width: widthOfString(text: greneList?[indexPath.row].name ?? "", font: UIFont(name: "Geeza Pro Regular", size: 14) ?? UIFont.systemFont(ofSize: 10))+30, height: 45)
        }
    }
    
    func widthOfString(text:String, font : UIFont)->CGFloat{
        let fontAttributes = [NSAttributedString.Key.font : font]
        let textsize = text.size(withAttributes: fontAttributes)
        return textsize.width
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = selectedMovieList[indexPath.row]
        if movie.title == nil {
            delegate?.onTapSerie(id: movie.id ?? 0)
        } else {
            delegate?.onTapMovie(id: movie.id ?? 0)
        }
    }
    
}
