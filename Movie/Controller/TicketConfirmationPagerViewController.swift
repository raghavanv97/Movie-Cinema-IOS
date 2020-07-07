//
//  TicketConfirmationPagerViewController.swift
//  Movie
//
//  Created by vijay raghavan on 06/07/20.
//  Copyright © 2020 vijay raghavan. All rights reserved.
//

import UIKit

class TicketConfirmationPagerViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var typePager: String?
    var movieName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.layer.cornerRadius = 10
        if let type = typePager {
            switch type {
            case "swipe":
                labelText.text = "SWIPE TO CONFIRM"
                labelText.textColor = .white
                containerView.backgroundColor = UIColor(red: 0.52, green: 0.55, blue: 0.80, alpha: 1.00)
                view.backgroundColor = .white
                imageView.removeFromSuperview()
                
            case "ticket":
                labelText.text = "Ticket Booked"
                labelText.textColor = .black
                let image = BarCodeImageView(barcode: movieName!)
                imageView.image = image
                
            default:
                break
            }
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

}
