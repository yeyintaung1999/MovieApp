//
//  MoreShowCaseViewController.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 26/03/2022.
//

import UIKit

class MoreShowCaseViewController: UIViewController, MovieItemDelegate {

    
    
    @IBOutlet weak var moreShowCaseCollectionView: UICollectionView!
    
    let networkAgent = NetworkAgent.shared
    
    var initdata : MovieListResponse?
    
    var data : [MovieResult] = []
    
    var totalPage : Int = 1
    var currentPage : Int = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()

        moreShowCaseCollectionView.dataSource = self
        moreShowCaseCollectionView.delegate = self
        moreShowCaseCollectionView.registerForCell(identifier: ShowcaseCollectionViewCell.identifier)
        
        initState()
    }
    
    func onTapMovie(id: Int) {
        navigateToMovieDetailViewController(movieId: id)
    }
    
    func onTapSerie(id: Int) {
        
    }
    
    func initState(){
        
        totalPage = initdata?.totalPages ?? 1
        currentPage = initdata?.page ?? 1
        
        data.append(contentsOf: initdata?.results ?? [MovieResult]())
        self.moreShowCaseCollectionView.reloadData()
        
    }

    func fetchData(page: Int){
        networkAgent.getShowCaseMovieList(page: page) { result in
            switch result{
            case .success(let data):
                self.data.append(contentsOf: data.results ?? [MovieResult]())
                self.moreShowCaseCollectionView.reloadData()
            case .failure(let message): print(message)
            }
        }
    }
}


extension MoreShowCaseViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCells(identifier: ShowcaseCollectionViewCell.identifier
                                               , indexPath: indexPath) as ShowcaseCollectionViewCell
        cell.data = data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = (width/4)*2
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isAtLastRow = indexPath.row == data.count-1
        let hasMorePage = currentPage < totalPage
        
        if isAtLastRow && hasMorePage {
            currentPage = currentPage + 1
            fetchData(page: currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.onTapMovie(id: data[indexPath.row].id ?? 0)
    }
}
