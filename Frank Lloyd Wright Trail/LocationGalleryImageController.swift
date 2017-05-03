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
        var photos = [ExamplePhoto]()
        switch indexTapped {
            case 0: photos = PhotosProvider.getPhotos0()
            case 1: photos = PhotosProvider.getPhotos1()
            case 2: photos = PhotosProvider.getPhotos2()
            case 3: photos = PhotosProvider.getPhotos3()
            case 4: photos = PhotosProvider.getPhotos4()
            case 5: photos = PhotosProvider.getPhotos5()
            case 6: photos = PhotosProvider.getPhotos6()
            case 7: photos = PhotosProvider.getPhotos7()
            default: break
        }
        //let photos = nytPhotoDictionary[indexTapped]
        let photosViewController = NYTPhotosViewController(photos: photos, initialPhoto: photos[initialIndex])
        present(photosViewController, animated: true, completion: nil)
    }
    
    
   }
