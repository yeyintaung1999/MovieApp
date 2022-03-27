//
//  BestActorTableViewCell.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 17/02/2022.
//

import UIKit

class BestActorTableViewCell: UITableViewCell, ActorActionDelegate{

    weak var delegate2 : MoreActorDelegate?=nil
    
    weak var delegate : OnTapActorDelegate?=nil

    @IBOutlet weak var bestactorcollectionviewcell: UICollectionView!
    @IBOutlet weak var moreactorlbl: UILabel!
    
    var data : ActorListResponse?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        moreactorlbl.underlineText(text: "MORE ACTORS")
        
        bestactorcollectionviewcell.dataSource = self
        bestactorcollectionviewcell.delegate = self
        bestactorcollectionviewcell.registerForCell(identifier: BestActorCollectionViewCell.identifier)
        
        inittapGesture()
        
    }
    
    func inittapGesture(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ontapmore))
        moreactorlbl.isUserInteractionEnabled = true
        moreactorlbl.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func ontapmore(){
        delegate2?.onTapSeeMore()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func onTapFavorite(isFavorite: Bool) {
        
    }
    
    func onTapActor(id: Int) {
        
    }
    
}

extension BestActorTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCells(identifier: BestActorCollectionViewCell.identifier, indexPath: indexPath) as BestActorCollectionViewCell
        cell.delegate = self
        
        cell.data = data?.results?[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data?.results?[indexPath.row]
        delegate?.onTapActor(id: item?.id ?? 0)
    }
    
}
