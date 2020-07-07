//
//  BarCodeImageView.swift
//  Movie
//
//  Created by vijay raghavan on 06/07/20.
//  Copyright © 2020 vijay raghavan. All rights reserved.
//

import UIKit

class BarCodeImageView: UIImage {

    convenience init?(barcode: String) {
        let data = barcode.data(using: .ascii)
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        guard let ciImage = filter.outputImage else {
            return nil
        }
        self.init(ciImage: ciImage)
    }
    
}
