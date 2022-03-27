//
//  ShowMoreActorViewController.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 25/03/2022.
//

import UIKit

class ShowMoreActorViewController: UIViewController, OnTapActorDelegate {
    func onTapActor(id: Int) {
        navigateToMovieDetailViewController(actorId: id)
    }
    
    
    var actorList : MoreActorResponse?
    
    let networkAgent = NetworkAgent.shared
    
    var data : [ActorResult] = []
    
    var totalPage : Int = 1
    var currentPage : Int = 1
    
    
    @IBOutlet weak var actorCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actorCollectionView.dataSource = self
        actorCollectionView.delegate = self
        actorCollectionView.registerForCell(identifier: BestActorCollectionViewCell.identifier)

        initState()
        
    }

    func initState(){
        currentPage = actorList?.page ?? 1
        totalPage = actorList?.totalPages ?? 1
        
        self.data.append(contentsOf: actorList?.results ?? [ActorResult]())
        actorCollectionView.reloadData()
    }
    
    private func fetchData (page: Int){
        networkAgent.getMoreActorList(page: page) { result in
            switch result {
            case .success(let data):
                self.data.append(contentsOf: data.results ?? [ActorResult]())
                self.actorCollectionView.reloadData()
            case .failure(let message): print(message)
            }
        }

    }
    
    


}

extension ShowMoreActorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCells(identifier: BestActorCollectionViewCell.identifier, indexPath: indexPath) as BestActorCollectionViewCell
        
        cell.data = data[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/3.1
        let height = (width/3)*4
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isAtLastRow = (indexPath.row == ( data.count - 1))
        let hasMorePage = currentPage < totalPage
        if isAtLastRow && hasMorePage {
            
            currentPage += 1
            
            fetchData(page: currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.onTapActor(id: data[indexPath.row].id ?? 0)
    }
    
    
}
