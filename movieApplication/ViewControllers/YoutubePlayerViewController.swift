//
//  YoutubePlayerViewController.swift
//  movieApplication
//
//  Created by Ye Yint Aung on 24/03/2022.
//

import UIKit
import YouTubePlayer

class YoutubePlayerViewController: UIViewController {
    
    @IBOutlet var youtubeVideoPlayer: YouTubePlayerView!
    
    var youtubeID : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let id = youtubeID {
            youtubeVideoPlayer.loadVideoID(id)
            
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapClose(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
   


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
