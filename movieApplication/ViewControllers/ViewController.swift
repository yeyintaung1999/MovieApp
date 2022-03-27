

import UIKit

class ViewController: UIViewController, MovieItemDelegate, OnTapActorDelegate, MoreActorDelegate, MoreShowCaseDelegate{
    

    //MARK: outlets and vars
    
    
    @IBOutlet weak var menuBars: UIImageView!
    @IBOutlet weak var discoverLabel: UILabel!
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var baseTableView: UITableView!
    
    private let networkAgent : MovieModel = MovieModelImpl.shared
    
    private var upcomingMovieList : MovieListResponse?
    private var popularMovieList : MovieListResponse?
    private var popularSerieList : MovieListResponse?
    private var movieGenreList : MovieGenre?
    private var showCaseMovieList : MovieListResponse?
    private var bestActorList : ActorListResponse?
    public var movieDetail : MovieDetailResponse?
    public var moreActorList : MoreActorResponse?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        fetchUpcomingMovieList()
        fetchPopularMovieList()
        fetchPopularSerieList()
        fetchMovieGenreList()
        fetchShowCaseMovieList()
        fetchActorList()
        fetchMoreActorList()
    }
    

    
    //MARK: - Tap&RegisterCell Funcs
    
    private func registerTableViewCells(){
        baseTableView.dataSource = self
        
        baseTableView.delegate = self
        
        baseTableView.registerForCell(identifier: SliderTableViewCell.identifier)
        
        baseTableView.registerForCell(identifier: PopularFilmTableViewCell.identifier)
        
        baseTableView.registerForCell(identifier: ShowTimeTableViewCell.identifier)
        
        baseTableView.registerForCell(identifier: MovieGenreTableViewCell.identifier)
        
        baseTableView.registerForCell(identifier: ShowcasesTableViewCell.identifier)
        
        baseTableView.registerForCell(identifier: BestActorTableViewCell.identifier)
        
    }
    
    @IBAction func searchTap(_ sender: UIButton){
        navigateToSearchViewController()
    }
    
    func onTapMovie(id : Int) {
        navigateToMovieDetailViewController(movieId: id)
    }
    
    func onTapSerie(id: Int) {
        navigateToMovieDetailViewController(serieId: id)
    }

    func onTapActor(id: Int) {
        navigateToMovieDetailViewController(actorId: id)
    }
    
    func onTapMoreShowCase() {
        if let data = showCaseMovieList{
            navigateToMoreShowCaseViewController(data: data)
        }
    }
    
    func onTapSeeMore() {
        if let data = moreActorList {
            navigateToShowMoreActorViewController(data: data )
        }
    }
    
    //MARK: - FetchData Func
    
    
    private func fetchUpcomingMovieList(){
        networkAgent.getUpcomingMovieList(page: 1) { [weak self](result) in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.upcomingMovieList = data
                self.baseTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            case .failure(let message): print(message)
            }
            
        }
    }
    
    private func fetchPopularMovieList(){
        networkAgent.getPopularMovieList(page: 1) { [weak self](result) in
            guard let self = self else {return}
            switch result{
            case .success(let data):
                self.popularMovieList = data
                self.baseTableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            case .failure(let message): print(message)
            }

        }
    }
    
    private func fetchPopularSerieList(){
        networkAgent.getPopularSerieList { [weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .success(let data):
                self.popularSerieList = data
                self.baseTableView.reloadSections(IndexSet(integer: 2), with: .automatic)
            case .failure(let message): print(message)
            }
        }
    }
    
    private func fetchMovieGenreList(){
        networkAgent.getGenreList { [weak self](result) in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.movieGenreList = data
                self.baseTableView.reloadSections(IndexSet(integer: 4), with: .automatic)
            case .failure(let message): print(message)
            }
        }
    }
    
    private func fetchShowCaseMovieList(){
        networkAgent.getShowCaseMovieList(page: 1) { [weak self](result) in
            guard let self = self else {return}
            switch result{
            case .success(let data):
                self.showCaseMovieList = data
                self.baseTableView.reloadSections(IndexSet(integer: 5), with: .automatic)
            case .failure(let message): print(message)
            }
        }
    }
    
    private func fetchActorList(){
        networkAgent.getActorList(page: 1) { [weak self](result) in
            guard let self = self else {return}
            switch result{
            case .success(let data):
                self.bestActorList = data
                self.baseTableView.reloadSections(IndexSet(integer: 6), with: .automatic)
            case .failure(let message): print(message)
            }
        }
    }
    
    private func fetchMoreActorList(){
        networkAgent.getMoreActorList(page: 1) { [weak self](result) in
            guard let self = self else {return}
            switch result{
            case .success(let data):
                self.moreActorList = data
                self.baseTableView.reloadSections(IndexSet(integer: 6), with: .automatic)
            case .failure(let message): print(message)
            }
        }
    }
}

// MARK: - Extension Collection View

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case MovieType.MovieSlider.rawValue:
            let cell = tableView.dequeueCells(identifier: SliderTableViewCell.identifier, indexPath: indexPath) as SliderTableViewCell
            cell.delegate = self
            cell.data = upcomingMovieList
            return cell
        case MovieType.PopularMovie.rawValue:
            let cell = tableView.dequeueCells(identifier: PopularFilmTableViewCell.identifier, indexPath: indexPath) as PopularFilmTableViewCell
            cell.delegate = self
            cell.data1 = popularMovieList
            cell.data2 = nil
            cell.popularText.text = "Popular Films"
            return cell
        case MovieType.PopularSerie.rawValue:
            let cell = tableView.dequeueCells(identifier: PopularFilmTableViewCell.identifier, indexPath: indexPath) as PopularFilmTableViewCell
            cell.delegate = self
            cell.data1 = nil
            cell.data2 = popularSerieList
            cell.popularText.text = "Popular Series"
            return cell
        case MovieType.ShowTime.rawValue:
            return tableView.dequeueCells(identifier: ShowTimeTableViewCell.identifier, indexPath: indexPath)
        case MovieType.MovieGenre.rawValue:
            let cell = tableView.dequeueCells(identifier: MovieGenreTableViewCell.identifier, indexPath: indexPath) as MovieGenreTableViewCell
            
            
            
            var movieList : [MovieResult] = []
            movieList.append(contentsOf: popularMovieList?.results ?? [MovieResult]())
            movieList.append(contentsOf: popularSerieList?.results ?? [MovieResult]())
            movieList.append(contentsOf: upcomingMovieList?.results ?? [MovieResult]())
            
            
            let result_data : [GenreVO]? = movieGenreList?.genres.map{ genre -> GenreVO in
                return genre.convertToGenreVo()
            }
            
            result_data?.first?.isSelected = true
            
            cell.greneList = result_data
            cell.allMovieAndSeries = movieList
            cell.delegate = self
            
            return cell
        case MovieType.ShowCase.rawValue:
            let cell = tableView.dequeueCells(identifier: ShowcasesTableViewCell.identifier, indexPath: indexPath) as ShowcasesTableViewCell
            cell.delegate = self
            cell.showcaseDelegate = self
            cell.data = showCaseMovieList
            return cell
        case MovieType.BestActor.rawValue:
            let cell =  tableView.dequeueCells(identifier: BestActorTableViewCell.identifier, indexPath: indexPath) as BestActorTableViewCell
            cell.delegate = self
            cell.delegate2 = self
            cell.data = bestActorList
            return cell
            
        default :
            return UITableViewCell()

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return CGFloat(230)
        case 1 : return CGFloat(235)
        case 2 : return CGFloat(235)
        case 3 : return CGFloat(170)
        case 4:return CGFloat(280)
        case 5: return CGFloat(270)
        case 6: return CGFloat(250)
        default: return CGFloat(200)
        }
    }
}

