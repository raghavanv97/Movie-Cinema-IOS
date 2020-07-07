//
//  TicketConfirmationViewController.swift
//  Movie
//
//  Created by vijay raghavan on 04/07/20.
//  Copyright © 2020 vijay raghavan. All rights reserved.
//

import UIKit

class TicketConfirmationViewController: UIViewController {

    @IBOutlet weak var movieNameText: UILabel!
    @IBOutlet weak var movieDateText: UILabel!
    @IBOutlet weak var movieTimingText: UILabel!
    @IBOutlet weak var movieSeatsText: UILabel!
    @IBOutlet weak var movieNameTextLabel: UILabel!
    @IBOutlet weak var moviePosterImage: UIImageView!
    
    @IBOutlet weak var movieTicketBookedDetailedContainer: UIView!
    
    @IBOutlet weak var swipeToConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
 
    @IBOutlet weak var ticketConfirmationContainer: UIView!
    var movie: Movie?
    var selectedSeats: String?
    var selectedTiming: String?
    var selectedDate: String?
    
    var pagerViewController: UIPageViewController?
    
    var pageContainer: [UIViewController] {
        let swipeToConfirm = storyboard?.instantiateViewController(identifier: "TicketConfirmationPageVCID") as? TicketConfirmationPagerViewController
        swipeToConfirm?.typePager = "swipe"
        
        let bookedTicket = storyboard?.instantiateViewController(identifier: "TicketConfirmationPageVCID") as? TicketConfirmationPagerViewController
        bookedTicket?.typePager = "ticket"
        bookedTicket?.movieName = movie?.movieName
        
        return [swipeToConfirm!, bookedTicket!]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        movieTicketBookedDetailedContainer.layer.cornerRadius = 10
        containerHeightConstraint.constant = 0
        swipeToConstraint.constant = 0
        movieNameText.text = movie?.movieName
        movieNameTextLabel.text = movie?.movieName
        fetchImage(moviePoster: moviePosterImage, URL(string: movie!.moviePosterURL))
        movieDateText.text = selectedDate
        movieSeatsText.text = selectedSeats
        movieTimingText.text = selectedTiming

        
        pagerViewController = storyboard?.instantiateViewController(identifier: "pagerViewControllerID")
        pagerViewController?.dataSource = self
        pagerViewController?.delegate = self
        
        pageContainer[0].view.frame = ticketConfirmationContainer.bounds
        pageContainer[1].view.frame = ticketConfirmationContainer.bounds
        pagerViewController?.view.frame = ticketConfirmationContainer.bounds

        
        ticketConfirmationContainer.addSubview(pagerViewController!.view)
        pagerViewController?.setViewControllers([pageContainer[0]], direction: .forward, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let animation: UIView.AnimationOptions = .curveLinear
        
        UIView.animate(withDuration: 0.5, delay: 0, options: animation, animations: {
            self.swipeToConstraint.constant = 120
            self.view.superview?.layoutIfNeeded()
        }) { (b) in
            
            UIView.animate(withDuration: 1.0, delay: 0, options: animation, animations: {
                self.containerHeightConstraint.constant = 350
                self.view.superview?.layoutIfNeeded()
            }, completion: nil)
            
        }
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "homePageSegue", sender: self)
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


//MARK:- UIPageViewController Delegate
extension TicketConfirmationViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
//        let pageContent: TicketConfirmationPagerViewController = viewController as! TicketConfirmationPagerViewController
//
//        if let whichPage = pageContent.typePager {
//            if whichPage == "swipe" {
//                return nil
//            }
//        }
//
//        return self.pageContainer[0]
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: TicketConfirmationPagerViewController = viewController as! TicketConfirmationPagerViewController
        
        if let whichPage = pageContent.typePager {
            if whichPage == "ticket" {
                return nil
            }
        }
        
        return self.pageContainer[1]
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageContainer.count
    }
}
