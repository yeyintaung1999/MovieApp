
import UIKit
import SDWebImage

class PopularFimlCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backdropImage : UIImageView!
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var ratingLabel : UILabel!
    @IBOutlet weak var ratingStackView : RatingControl!
    
    var data : MovieResult? {
        didSet {
            if data != nil {
                let rating = data?.voteAverage
                var movieTitle : String?
                if data?.title == nil {
                    movieTitle = data?.name
                } else {movieTitle = data?.title}
                
                
                
                
                let backdropPath = "\(imageBaseUrl)\(data?.posterPath ?? "")"
                self.ratingStackView.rating = Int(rating!/Double(2))
                self.ratingLabel.text = "\(rating!)"
                self.title.text = movieTitle
                backdropImage.sd_setImage(with: URL(string: backdropPath))
            }
        }
    }
    


    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
