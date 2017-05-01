//
//  LocationGalleryImageController.swift
//  Frank Lloyd Wright Trail
//
//  Created by MichaelHorning on 9/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit
import NYTPhotoViewer
import MapKit

class LocationGalleryImageController: UIViewController, NYTPhotoViewControllerDelegate {
    
    var nytPhotoDictionary: [Int : [ExamplePhoto]] = [
        0 : PhotosProvider().photos0,
        1 : PhotosProvider().photos1,
        2 : PhotosProvider().photos2,
        3 : PhotosProvider().photos3,
        4 : PhotosProvider().photos4,
        5 : PhotosProvider().photos5,
        6 : PhotosProvider().photos6,
        7 : PhotosProvider().photos7,
    ]
    
    var statusBarHidden = false
    
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
    
    @IBOutlet weak var galleryImage: UIImageView!
    
    // var to take in image from LocationGalleryPageController
    var image: UIImage?
    // var from LocationGalleryPageController to use for correct site pictures
    var indexTapped: Int!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // UITapGestureRecognizer to display the correct [Example] photo

        let imageTapped = UITapGestureRecognizer(target: self, action: #selector(LocationGalleryImageController.tapped))

        self.galleryImage.addGestureRecognizer(imageTapped)
        if let image = image {
            galleryImage.image = image
        }
        statusBarHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        statusBarHidden = true
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    // switch statment to select correct photos
    func tapped(){
        let initialIndex = galleryImage.tag
        let photos = nytPhotoDictionary[indexTapped]
        let photosViewController = NYTPhotosViewController(photos: photos, initialPhoto: photos?[initialIndex])
        present(photosViewController, animated: true, completion: nil)

    }
    
    
   }
