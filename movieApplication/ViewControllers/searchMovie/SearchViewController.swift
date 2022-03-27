//
//  SearchViewController.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 26/03/2022.
//

import UIKit

class SearchViewController: UIViewController , MovieItemDelegate{
    func onTapMovie(id: Int) {
        navigateToMovieDetailViewController(movieId: id)
    }
    
    func onTapSerie(id: Int) {
        
    }
    
    
    let networkagent = NetworkAgent.shared
    
    private let  searchBar = UISearchBar()
    
    var initialData : MovieListResponse?
    var data : [MovieResult] = []
    var searchResult : MovieListResponse?
    
    @IBOutlet weak var searchResultCollectionView: UICollectionView!
    
    var totalPage : Int = 1
    var currentPage : Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.registerForCell(identifier: PopularFimlCollectionViewCell.identifier)

        initialFunc()
    }
    
    private func initialFunc(){
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        searchBar.searchTextField.textColor = .white
        navigationItem.titleView = searchBar
        
//        totalPage = initialData?.totalPages ?? 1
//        currentPage = initialData?.page ?? 1
//        data.append(contentsOf: initialData?.results ?? [MovieResult]())
//        self.searchResultCollectionView.reloadData()
    }
    
    private func searchContent(keyword: String, page: Int){
        
        fetchData(keyword: keyword, page: page)
        
    }
    
    private func fetchData(keyword: String, page: Int){
        
        networkagent.searchMovie(page: page, query: keyword) { [weak self](result) in
            guard let self = self else { return }
            switch result{
            case .success(let data):
                self.searchResult = data
                self.data.append(contentsOf: data.results ?? [MovieResult]())
                self.searchResultCollectionView.reloadData()
            case .failure(let message): print(message)
            }
        }
    }



}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCells(identifier: PopularFimlCollectionViewCell.identifier, indexPath: indexPath) as PopularFimlCollectionViewCell
        cell.data = data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/3.2
        let height = width*1.8
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.onTapMovie(id: data[indexPath.row].id ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isAtLastRow = data.count-1 == indexPath.row
        let hasMorePage = currentPage < totalPage
        if isAtLastRow && hasMorePage {
            currentPage = currentPage + 1
            searchContent(keyword: searchBar.text ?? " ", page: currentPage)
            searchResultCollectionView.reloadData()
        }
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if let string = searchBar.text {
            self.currentPage = 1
            self.totalPage = 1
            self.data.removeAll()
            
            searchContent(keyword: string, page: currentPage)
        }
    }
    
}
