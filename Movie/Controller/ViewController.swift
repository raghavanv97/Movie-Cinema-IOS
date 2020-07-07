//
//  ViewController.swift
//  Movie
//
//  Created by vijay raghavan on 19/06/20.
//  Copyright © 2020 vijay raghavan. All rights reserved.
//

import UIKit
import Koloda

class ViewController: UIViewController {
    
    var movieView = [MovieView]()
    var indexPositionOfMovie: Int = 0;
    var topContainerCGRect: CGRect?, bottomContainerCGRect: CGRect?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var swipeView: KolodaView!
    //    @IBOutlet weak var carouselView: iCarousel!
    
    var movies = MoviesList().getAllMovies()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        swipeView.dataSource = self
        swipeView.delegate = self
        
        loadAllMovies()
    }
    
    
    func loadAllMovies() {
        for i in 0..<movies.count {
            let view = MovieView(frame: CGRect(x: 0, y: 0, width: self.swipeView.frame.size.width, height: self.swipeView.frame.size.height))
            
            let posterURL = URL(string: movies[i].moviePosterURL)
            self.fetchImage(moviePoster: view.imageView, posterURL)
            
            view.movieDescription.text = movies[i].movieShortDescription
            view.movieName.text = movies[i].movieName
            view.movieIMDBText.text = movies[i].movieIMDB
            view.movie2Dor3DText.text = movies[i].twoDor3D
            view.movieCategory.text = movies[i].movieCategory
            
            self.movieView.append(view)
        }
        
        print("reload carousel")
        self.swipeView.reloadData()
    }
    
    
    private func fetchImage(moviePoster: UIImageView, _ photoURL: URL?) {
        
        guard let imageURL = photoURL else { return  }
        
        DispatchQueue.global(qos: .userInitiated).async {
            do{
                let imageData: Data = try Data(contentsOf: imageURL)
                
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
                    moviePoster.image = image
                    
                    moviePoster.sizeToFit()
                    
                }
            }catch{
                print("Unable to load data: \(error)")
            }
        }
    }
    
}


//MARK: - SwipeView Delegate
extension ViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        print("ran out of cards")
        koloda.resetCurrentCardIndex()
        self.swipeView.reloadData()
    }
    
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "ToMovieDetail", sender: self)
            self.topContainerCGRect = self.movieView[index].imageView.frame
            self.bottomContainerCGRect = self.movieView[index].bottomView.frame
        }
        print("selected positon \(index) \(String(describing: movieView[index].movieID))")
        indexPositionOfMovie = index
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMovieDetail" {
            let sc = segue.destination as! DetailedMovieViewController
            sc.movie = movies[indexPositionOfMovie]
        }
    }
    
}


//MARK: - SwipeView DataSource
extension ViewController: KolodaViewDataSource {
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return movieView[index]
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        movieView.count
    }    
    
}

