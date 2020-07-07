//
//  DetailedMovieViewController.swift
//  Movie
//
//  Created by vijay raghavan on 23/06/20.
//  Copyright © 2020 vijay raghavan. All rights reserved.
//

import UIKit

class DetailedMovieViewController: UIViewController {
    
    @IBOutlet weak var movieNameText: UILabel!
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!
    
    var movieDetaildChildVC: MovieDetailSubChildViewController?
    var movieTimingChildVC: MovieSessionTimingChildViewController?
    var movieTicketBookingChildVC: TicketBookingViewController?
    
    var moviePosterVC: MoviePosterViewController?
    
    var movie: Movie?
    
    var movieName: String?{
        didSet {
            movieNameText.text = movieName
        }
    }
    var moviePosterURL: URL?{
        didSet {
            moviePosterVC?.moviePosterURL = moviePosterURL
        }
    }
    
    var movieTrailer: String? {
        didSet {
            moviePosterVC?.movieTrailer = movieTrailer
        }
    }
    var genre: String = ""
    
    var theatreMaskImageView: UIImageView?
    
    var selectedTiming: String?
    var selectedDate: String?
    var selectedSeats: String?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        topContainerView.layer.cornerRadius = 10
        bottomContainerView.layer.cornerRadius = 10
        movieDetaildChildVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "MovieDetailSubChildVCID") as? MovieDetailSubChildViewController
        
        if let childVC = movieDetaildChildVC {
            addChild(childVC)
            childVC.view.frame = bottomContainerView.bounds
            bottomContainerView.addSubview(childVC.view)
            childVC.didMove(toParent: self)
            childVC.movieName = movie!.movieName
            childVC.movieCategory = movie!.movieCategory
            childVC.movieDescription = movie!.movieShortDescription
            childVC.movieIMDB = movie!.movieIMDB
            childVC.movie2Dor3D = movie!.twoDor3D
        }
        
        movieName = movie?.movieName
        moviePosterURL = URL(string: movie?.moviePosterURL ?? "")
        movieTrailer = movie?.movieTrailer
        
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMoviePosterSegue" {
            moviePosterVC = segue.destination as? MoviePosterViewController
            
        }else if segue.identifier == "ToMovieDetailSegue" {
            
        }else if segue.identifier == "ticketConfirmationSegue" {
            let destVC = segue.destination as? TicketConfirmationViewController
            destVC?.movie = movie
            destVC?.selectedSeats = selectedSeats
            destVC?.selectedTiming = selectedTiming
            destVC?.selectedDate = selectedDate
        }
    }
    
    
    //MARK:- Movie Session Timing Screen
    
    func changeToSessionTimeVC() {
        movieTimingChildVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "MovieSessionTimingVC") as? MovieSessionTimingChildViewController
        
        if let childVC = movieTimingChildVC, let previousVC = movieDetaildChildVC {
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
            
            
            addChild(childVC)
            childVC.view.frame = bottomContainerView.bounds
            bottomContainerView.addSubview(childVC.view)
            childVC.didMove(toParent: self)
        }
    }
    
    
    //MARK:- Ticket Booking Screen
    
    func changeToTicketBookingVC() {
        movieTicketBookingChildVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TicketBookingSID") as? TicketBookingViewController
        
        if let childVC = movieTicketBookingChildVC, let previousVC = movieTimingChildVC {
            
            previousVC.view.alpha = 1.0
            previousVC.willMove(toParent: nil)
            
            self.addChild(childVC)
            childVC.view.frame = self.bottomContainerView.bounds
            childVC.view.alpha = 0.0
            self.bottomContainerView.addSubview(childVC.view)
            childVC.didMove(toParent: self)

            UIView.animate(withDuration: 1.0, animations: {
                previousVC.view.alpha = 0.0
                childVC.view.alpha = 1.0
            }) { (bool) in
                previousVC.view.removeFromSuperview()
                previousVC.removeFromParent()
            }
            
            self.theatreScreen()
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:- Animate Theatre Screen
    
    func theatreScreen() {
        
        if let childVC = moviePosterVC {
            
            theatreMaskImageView = UIImageView()
            theatreMaskImageView!.contentMode = .scaleToFill
            theatreMaskImageView!.image = #imageLiteral(resourceName: "Theatre_Screen_1")
            theatreMaskImageView!.frame = childVC.youtubePlayer.bounds
            
            UIView.animate(withDuration: 1.0) {
                
                
                childVC.youtubePlayer.mask = self.theatreMaskImageView!
                
                let degrees = 50.0
                let radians = CGFloat(degrees * .pi / 180)
                childVC.youtubePlayer.layer.transform = CATransform3DMakeRotation(radians, 1.0, 0.0, 0.0)
                
//                let radius: CGFloat = self.theatreMaskImageView!.frame.height / 2.0 //change it to .height if you need spread for height
//                let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: self.theatreMaskImageView!.bounds.maxY - self.theatreMaskImageView!.layer.shadowRadius, width: 2.1 * radius, height: self.theatreMaskImageView!.frame.height))
//                //Change 2.1 to amount of spread you need and for height replace the code for height
//
//                self.theatreMaskImageView!.layer.cornerRadius = 2
//                self.theatreMaskImageView!.layer.shadowColor = UIColor.black.cgColor
//                self.theatreMaskImageView!.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)  //Here you control x and y
//                self.theatreMaskImageView!.layer.shadowOpacity = 0.5
//                self.theatreMaskImageView!.layer.shadowRadius = 5.0 //Here your control your blur
//                self.theatreMaskImageView!.layer.masksToBounds =  false
//                self.theatreMaskImageView!.layer.shadowPath = shadowPath.cgPath
                
            }
            
            
        }
    }
    
    
    //MARK:- Animate Theatre Screen
    
    func closeTheatreScreen() {
        
        if let maskImage = theatreMaskImageView, let topContainerVC = moviePosterVC, let bottonContainerVC = movieTicketBookingChildVC {
            bottonContainerVC.view.alpha = 1.0
            bottonContainerVC.willMove(toParent: nil)
            
            UIView.animate(withDuration: 1.0, animations: {
                maskImage.frame = CGRect(x: 0.0, y: 140.0, width: maskImage.bounds.size.width, height: 5.0)
                bottonContainerVC.view.alpha = 0.0
            }) { (bool) in
                topContainerVC.youtubePlayer.stopVideo()
                
                bottonContainerVC.view.removeFromSuperview()
                bottonContainerVC.removeFromParent()
                
                self.performSegue(withIdentifier: "ticketConfirmationSegue", sender: self)
            }
        }
    }
    
}
