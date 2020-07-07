//
//  RoundCornerButton.swift
//  Movie
//
//  Created by vijay raghavan on 29/06/20.
//  Copyright © 2020 vijay raghavan. All rights reserved.
//

import UIKit

@IBDesignable class RoundCornerButton: UIButton
{
    override func layoutSubviews() {
        super.layoutSubviews()

        updateCornerRadius()
    }

    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }

    func updateCornerRadius() {
        layer.cornerRadius = rounded ? 7 : 0
        clipsToBounds = rounded
//        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
}
