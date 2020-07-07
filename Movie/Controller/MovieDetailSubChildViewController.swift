//
//  MovieDetailSubChildViewController.swift
//  Movie
//
//  Created by vijay raghavan on 24/06/20.
//  Copyright © 2020 vijay raghavan. All rights reserved.
//

import UIKit

class MovieDetailSubChildViewController: UIViewController {

    
    @IBOutlet weak var movieNameText: UILabel!
    @IBOutlet weak var movieCategoryText: UILabel!
    @IBOutlet weak var movieDescriptionText: UILabel!
    @IBOutlet weak var twoDor3D: UILabel!
    @IBOutlet weak var imdbText: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var sessionTimeButton: UIButton!
    
    var movieName: String = "" {
        didSet {
            movieNameText.text = movieName
        }
    }
    
    var movieCategory: String = "" {
        didSet {
            movieCategoryText.text = movieCategory
        }
    }
    
    var movieDescription: String = "" {
        didSet {
            movieDescriptionText.text = movieDescription
        }
    }
    
    var movieIMDB: String = "" {
        didSet {
            imdbText.text = movieIMDB
        }
    }
    
    var movie2Dor3D: String = "" {
        didSet {
            twoDor3D.text = movie2Dor3D
        }
    }
    
    
    
    var parentVC: DetailedMovieViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.layer.cornerRadius = 10
        containerView.layer.cornerRadius = 10
        sessionTimeButton.layer.contents = 10
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        parentVC = parent as? DetailedMovieViewController
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func sessionTimingClicked(_ sender: Any) {
        if let parent = parentVC {
            parent.changeToSessionTimeVC()
        }
    }

}
