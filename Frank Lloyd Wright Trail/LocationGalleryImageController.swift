//
//  LocationGalleryImageController.swift
//  Frank Lloyd Wright Trail
//
//  Created by MichaelHorning on 9/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class LocationGalleryImageController: UIViewController {
    @IBOutlet weak var galleryImage: UIImageView!
    var image: UIImage?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let image = image {
            galleryImage.image = image
        }
    }
    
}
