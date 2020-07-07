//
//  MovieView.swift
//  Movie
//
//  Created by vijay raghavan on 19/06/20.
//  Copyright © 2020 vijay raghavan. All rights reserved.
//

import UIKit

class MovieView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
 


    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var movieCategory: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieIMDBText: UILabel!
    @IBOutlet weak var movie2Dor3DText: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var movieID: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("SingleMovie", owner: self, options: nil)
        addSubview(containerView)
        imageView.layer.cornerRadius = 25
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "MovieView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

}
