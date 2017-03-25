//
//  Photo.swift
//  Frank Lloyd Wright Trail
//
//  Created by MichaelHorning on 9/30/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import UIKit
import NYTPhotoViewer

// creates object that uses NYTPhoto protocal
class ExamplePhoto:NSObject ,NYTPhoto{
    

    var image: UIImage?
    var imageData: Data?
    var placeholderImage: UIImage?
    let attributedCaptionTitle: NSAttributedString?
    let attributedCaptionSummary: NSAttributedString? = NSAttributedString(string: "summary string", attributes: [NSForegroundColorAttributeName: UIColor.gray])
    let attributedCaptionCredit: NSAttributedString? = NSAttributedString(string: "credit", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
    
    init(image: UIImage? = nil, imageData: Data? = nil, attributedCaptionTitle: NSAttributedString) {
        self.image = image
        self.imageData = imageData
        self.attributedCaptionTitle = attributedCaptionTitle
        super.init()
    }
    
}
