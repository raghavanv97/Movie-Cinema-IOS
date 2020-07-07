//
//  MoviePosterViewController.swift
//  Movie
//
//  Created by vijay raghavan on 24/06/20.
//  Copyright © 2020 vijay raghavan. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class MoviePosterViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var youtubePlayer: YTPlayerView!
    
    
    var moviePosterURL: URL?{
        didSet{
            print("inside child view controller \(String(describing: moviePosterURL?.absoluteString))")
            fetchImage(moviePosterURL)
        }
    }
    
    var movieTrailer: String? {
        didSet {
            youtubePlayer.delegate = self
            youtubePlayer.load(withVideoId: movieTrailer!, playerVars: ["playsinline" : 1, "controls" : 0])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePoster.layer.cornerRadius = 25
        imagePoster.isHidden = true
        youtubePlayer.layer.cornerRadius = 25
        
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func fetchImage(_ photoURL: URL?) {

        guard let imageURL = photoURL else { return  }

        DispatchQueue.global(qos: .userInitiated).async {
            do{
                let imageData: Data = try Data(contentsOf: imageURL)

                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
                    self.imagePoster.image = image
                    
                    self.imagePoster.sizeToFit()
                    
                }
            }catch{
                print("Unable to load data: \(error)")
            }
        }
    }

}
