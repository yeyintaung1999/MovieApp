//
//  MovieDetailViewController.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 18/02/2022.
//

import UIKit

class MovieDetailViewController: UIViewController, OnTapActorDelegate, MovieItemDelegate {

//MARK: - Outlets
    @IBOutlet weak var productionView: UIView!
    @IBOutlet weak var seemoreOutlet: UIButton!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    //view to Hide in ActorDetail
    
    @IBOutlet weak var productionCollectionView: UIView!
    @IBOutlet weak var actorCollectionView: UIView!
    @IBOutlet weak var playTrailerView: UIView!
    @IBOutlet weak var clockImage: UIImageView!
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var productionStack: UIStackView!
    @IBOutlet weak var descriptionStack: UIStackView!
    
    //views to change text
    @IBOutlet weak var storylineTitle: UILabel!// BIOGRAPHY
    @IBOutlet weak var originalTitleTitle: UILabel!// Full Name
    @IBOutlet weak var typeTitle: UILabel!//Gender
    @IBOutlet weak var premierTitle: UILabel!//Birthday
    @IBOutlet weak var similarMovieTitle: UILabel!//Movies
    @IBOutlet weak var aboutFileLabel: UILabel!//ABOUT
    
    @IBOutlet weak var ratemoviebtn: UIButton!
    @IBOutlet weak var playtrailerbtn: UIButton!
    
    @IBOutlet weak var ivBack: UIImageView!
    
    @IBOutlet weak var similarMovieCollectionView: UICollectionView!
    @IBOutlet weak var actorCollectionCell: UICollectionView!
    @IBOutlet weak var productionCompanies : UICollectionView!
    
    @IBOutlet weak var backDropImage : UIImageView!
    @IBOutlet weak var releaseYear : UILabel!
    @IBOutlet weak var movieTitle : UILabel!
    @IBOutlet weak var screenTime : UILabel!
    @IBOutlet weak var totalVotes : UILabel!
    @IBOutlet weak var ratingControl : RatingControl!
    @IBOutlet weak var movieRating : UILabel!
    @IBOutlet weak var storyLine : UILabel!
    @IBOutlet weak var originalTitle : UILabel!
    @IBOutlet weak var movietype : UILabel!
    @IBOutlet weak var production : UILabel!
    @IBOutlet weak var premiere : UILabel!
    @IBOutlet weak var movieDescription : UILabel!
    
    //MARK: - VO vars
    
    var movieId : Int = -1
    var actorId : Int = -1
    
    var type : ContentType?
    
    var productionData : [ProductionCompany]? {
        didSet {
            productionCompanies.reloadData()
        }
    }
    var networkData : [Network]? {
        didSet {
            productionCompanies.reloadData()
        }
    }
    var similarMovie : [MovieResult]?
    var movieCreditData : MovieCreditResponse?
    var trailerData : [TrailerResult]?
    var combinedCredit : [MovieResult]?
    
    let networkAgent = NetworkAgent.shared
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playtrailerbtn.titleLabel?.textColor=UIColor.white
        playtrailerbtn.imageView?.tintColor=UIColor.gray
        
        ratemoviebtn.titleLabel?.textColor=UIColor.white
        ratemoviebtn.imageView?.tintColor=UIColor.yellow
        
        //initGestureRecognizer()
        
        actorCollectionCell.dataSource = self
        actorCollectionCell.registerForCell(identifier: BestActorCollectionViewCell.identifier)
        actorCollectionCell.delegate = self
        
        similarMovieCollectionView.dataSource = self
        similarMovieCollectionView.delegate=self
        similarMovieCollectionView.registerForCell(identifier: PopularFimlCollectionViewCell.identifier)
        
        productionCompanies.dataSource = self
        productionCompanies.delegate = self
        productionCompanies.registerForCell(identifier: productionCompanyCollectionViewCell.identifier)
        
        
        fetchDatatoBind(idactor: actorId, idmovie: movieId, contentType: type!)
        playtrailerbtn.isHidden = true
        
        storyLine.numberOfLines = 3
        
    }
    //MARK: - OnTapFunc
    @IBAction func seeMorebutton(_ sender: Any) {
        if storyLine.numberOfLines == 3 {
            storyLine.numberOfLines = 0
            seemoreOutlet.setTitle("See less..", for: .normal)
        } else {
            storyLine.numberOfLines = 3
            seemoreOutlet.setTitle("See more..", for: .normal)
        }
    }
    
    func onTapMovie(id: Int) {
        navigateToMovieDetailViewController(movieId: id)
    }
    
    func onTapSerie(id: Int) {
        navigateToMovieDetailViewController(serieId: id)
    }
    
    
    func onTapActor(id : Int){
        navigateToMovieDetailViewController(actorId: id)
    }
    
    @IBAction func playTrailerButton(_ sender: UIButton) {
        
        let youtubeId = trailerData?[0].key
        let youtubePlayerVC = YoutubePlayerViewController()
        youtubePlayerVC.youtubeID = youtubeId
        self.present(youtubePlayerVC, animated: true, completion: nil)
        youtubePlayerVC.modalPresentationStyle = .fullScreen
        youtubePlayerVC.modalTransitionStyle = .coverVertical
        
        
    }
    
    
    private func initGestureRecognizer(){
        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapBack) )
        ivBack.isUserInteractionEnabled = true
        ivBack.addGestureRecognizer(tapGestRecognizer)
    }
    
    @objc func onTapBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - FetchData Func
    func fetchDatatoBind(idactor : Int, idmovie: Int, contentType : ContentType){
        
        switch contentType {
        case .contentMovie:
            fetchMovieDetail(id: idmovie)
            fetchSimilarById(id: movieId)
        case .contentSerie:
            fetchSerieDetail(id: idmovie)
            fetchSimilarById(id: movieId)
        case .contentActor:
            fetchActorDetail(id: idactor)
            fetchCombinedCredit(id: idactor)
        }
        fetchMovieCreditById(id: movieId )
        
        fetchMovieTrailerByid(id: movieId)
        
    }
    
    


    
    private func fetchMovieDetail(id: Int){
        networkAgent.getMovieDetail(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result{
            case .success(let data):
                self.bindData(data: data)
                self.productionData = data.productionCompanies
                self.productionCompanies.reloadData()
            case .failure(let message): print(message)
            }
        }
        
    }
    
    private func fetchSerieDetail(id: Int){
        networkAgent.getSerieDetail(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.bindDataSerie(data: data)
                self.productionCompanies.reloadData()
            case .failure(let message): print(message)
            }
        }
        
    }
    
    private func fetchActorDetail(id:Int){
        networkAgent.getActorDetail(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result{
            case .success(let data):
                
                self.bindDataActor(data: data)
            case .failure(let message): print(message)
            }
            
        }

    }
    
    private func fetchMovieCreditById(id : Int){
        networkAgent.getMovieCredit(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result{
            case .success(let data):
                self.movieCreditData = data
                self.actorCollectionCell.reloadData()
            case .failure(let message): print(message)
            }
        }
        
    }
    
    private func fetchSimilarById(id : Int){
        networkAgent.getSimilarMovie(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result{
            case .success(let data):
                self.similarMovie = data.results
                self.similarMovieCollectionView.reloadData()
            case .failure(let message): print(message)
            }
        }
    }
    
    private func fetchMovieTrailerByid(id : Int){
        networkAgent.getMovieTrailer(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.trailerData = data.results
                self.playtrailerbtn.isHidden = (self.trailerData == nil)
            case .failure(let message): print(message)
            }
        }
    }
    
    private func fetchCombinedCredit(id: Int){
        print("\(id)")
        networkAgent.getCombinedCredit(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.similarMovie = data.cast
                self.similarMovieCollectionView.reloadData()
            case .failure(let message): print(message)
            }
        }
    }
    
    // MARK: - BindData Func
    
    private func bindData(data : MovieDetailResponse){
        let backdropPath = "\(imageBaseUrl)\(data.backdropPath ?? "")"
        let hour = Int((data.runtime ?? 0)/60)
        let mins = (data.runtime ?? 0 )-(hour*60)
        var type = "  "
        data.genres?.forEach({ item in
            type += "\(item.name ), "
        })
        type.removeLast()
        type.removeLast()
        var production1 = "  "
        data.productionCompanies?.forEach({ item in
            production1 += "\(item.name ?? ""), "
        })
        production1.removeLast()
        production1.removeLast()
        backDropImage.sd_setImage(with: URL(string: backdropPath))
        releaseYear.text = String(data.releaseDate?.split(separator: "-")[0] ?? " " )
        movieTitle.text = data.title ?? ""
        screenTime.text = "\(hour)hr \(mins)min"
        totalVotes.text = "\(data.voteCount ?? 0) votes"
        movieRating.text = "\(data.voteAverage ?? 0)"
        storyLine.text = data.overview ?? ""
        originalTitle.text = data.originalTitle
        self.navigationItem.title = data.originalTitle
        movietype.text = type
        production.text = production1
        premiere.text = data.releaseDate
        movieDescription.text = data.overview
        ratingControl.rating = Int((data.voteAverage ?? 0)/2)
    }
    
    private func bindDataSerie(data : MovieDetailResponse){
        self.productionView.isHidden = true
        productionStack.isHidden = true
        let backdropPath = "\(imageBaseUrl)\(data.backdropPath ?? "")"
        var type = "  "
        data.genres?.forEach({ item in
            type += "\(item.name), "
        })
        type.removeLast()
        type.removeLast()
        
        backDropImage.sd_setImage(with: URL(string: backdropPath))
        releaseYear.text = String(data.firstAirDate?.split(separator: "-")[0] ?? " " )
        movieTitle.text = data.name ?? ""
        screenTime.text = "\(data.episodeRunTime![0])min per Episode"
        totalVotes.text = "\(data.voteCount ?? 0) votes"
        movieRating.text = "\(data.voteAverage ?? 0)"
        storyLine.text = data.overview ?? ""
        originalTitle.text = data.name ?? ""
        movietype.text = type
        premiere.text = data.firstAirDate
        movieDescription.text = data.overview
        ratingControl.rating = Int((data.voteAverage ?? 0)/2)
        
    }
    
    private func bindDataActor(data: ActorDetailResponse){
        imageHeight.constant = 450
        playTrailerView.isHidden = true
        productionCollectionView.isHidden = true
        actorCollectionView.isHidden = true
        clockImage.isHidden = true
        heartImage.isHidden = true
        productionStack.isHidden = true
        descriptionStack.isHidden = true
        ratingControl.isHidden = true
        releaseYear.isHidden = true
        screenTime.text = data.knownForDepartment ?? ""
        premierTitle.text = "Birthday"
        premiere.text = data.birthday ?? ""
        originalTitleTitle.text = "Full Name"
        originalTitle.text = data.name ?? ""
        typeTitle.text = "Gender"
        var gender : String?
        if data.gender == 2 {
            gender = "Male"
        } else {
            gender = "Female"
        }
        movietype.text = gender
        storylineTitle.text = "BIOGRAPHY"
        storyLine.text = data.biography ?? ""
        movieTitle.text = data.name ?? ""
        let backdropPath = "\(imageBaseUrl)\(data.profilePath ?? "")"
        backDropImage.sd_setImage(with: URL(string: backdropPath))
    }
    
    
}

// MARK: - Extensions CollectionView


extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productionCompanies{
            return productionData?.count ?? 0
        }
        else if collectionView == actorCollectionCell {
            return movieCreditData?.cast?.count ?? 0
        } else {
            return similarMovie?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productionCompanies {
            let cell = collectionView.dequeueCells(identifier: productionCompanyCollectionViewCell.identifier, indexPath: indexPath) as productionCompanyCollectionViewCell
            
            switch type{
            case .contentMovie:
                let pcData = productionData?[indexPath.row]
                cell.data1 = pcData
                
                if pcData?.logoPath == nil || ((pcData?.logoPath!.isEmpty) == true) {
                    cell.productionName.text = pcData?.name
                } else {
                    cell.productionName.text = " "
                }
            case .contentSerie:
                let pcData = networkData?[indexPath.row]
                
                cell.data1 = nil
                
                if pcData?.logoPath == nil || ((pcData?.logoPath!.isEmpty) == true) {
                    cell.productionName.text = pcData?.name
                } else {
                    cell.productionName.text = " "
                }
                
            case .contentActor:
                let pcData = productionData?[indexPath.row]
                cell.data1 = nil
                
                if pcData?.logoPath == nil || ((pcData?.logoPath!.isEmpty) == true) {
                    cell.productionName.text = pcData?.name
                } else {
                    cell.productionName.text = " "
                }
                
            case .none:
                print("Error")
            }

            return cell
        } else if collectionView == actorCollectionCell {
            let cell = collectionView.dequeueCells(identifier: BestActorCollectionViewCell.identifier, indexPath: indexPath) as BestActorCollectionViewCell
            cell.data = movieCreditData?.cast?[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueCells(identifier: PopularFimlCollectionViewCell.identifier, indexPath: indexPath) as PopularFimlCollectionViewCell

            cell.data = similarMovie?[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == productionCompanies {
            return CGSize(width: ((collectionView.frame.height*0.3)*4), height: collectionView.frame.height)
        } else if collectionView == actorCollectionCell{
            let width = collectionView.frame.width/3
            let height = width*1.9
            return CGSize(width: width, height: height)
        } else {
            let width = collectionView.frame.width/3
            let height = width*1.7
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == actorCollectionCell {
            self.onTapActor(id: movieCreditData?.cast?[indexPath.row].id ?? 0)
        }else {
            
            self.onTapMovie(id: similarMovie?[indexPath.row].id ?? 0)
            
        }
    }
    
}


