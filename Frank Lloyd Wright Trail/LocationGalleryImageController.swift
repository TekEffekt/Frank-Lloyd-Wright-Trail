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
    
    // setting all the [Example] objects to be used
    let photos1 = PhotosProvider().photos1
    let photos2 = PhotosProvider().photos2
    let photos3 = PhotosProvider().photos3
    let photos4 = PhotosProvider().photos4
    let photos5 = PhotosProvider().photos5
    let photos6 = PhotosProvider().photos6
    let photos7 = PhotosProvider().photos7
    let photos8 = PhotosProvider().photos8
    
    @IBOutlet weak var galleryImage: UIImageView!
    
    // var to take in image from LocationGalleryPageController
    var image: UIImage?
    // var from LocationGalleryPageController to use for correct site pictures
    var nytphoto: Double?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // UITapGestureRecognizer to display the correct [Example] photo

        let imageTapped = UITapGestureRecognizer(target: self, action: "tapped")

        self.galleryImage.addGestureRecognizer(imageTapped)
        if let image = image {
            galleryImage.image = image
        }
    }
    
    // switch statment to select correct photos
    func tapped(){
        switch  nytphoto!{
        case 43.0105838:
            let photosViewController = NYTPhotosViewController(photos: self.photos7)
            presentViewController(photosViewController, animated: true, completion: nil)
        case 43.1192397:
            let photosViewController = NYTPhotosViewController(photos: self.photos8)
            presentViewController(photosViewController, animated: true, completion: nil)
        case 42.7152375:
            let photosViewController = NYTPhotosViewController(photos: self.photos1)
                presentViewController(photosViewController, animated: true, completion: nil)
        case 42.784472:
            let photosViewController = NYTPhotosViewController(photos: self.photos2)
            presentViewController(photosViewController, animated: true, completion: nil)
        case 43.0717445:
            let photosViewController = NYTPhotosViewController(photos: self.photos3)
            presentViewController(photosViewController, animated: true, completion: nil)
        case 43.0757361:
            let photosViewController = NYTPhotosViewController(photos: self.photos4)
            presentViewController(photosViewController, animated: true, completion: nil)
        case 43.1439006:
            let photosViewController = NYTPhotosViewController(photos: self.photos5)
            presentViewController(photosViewController, animated: true, completion: nil)
        case 43.3334718:
            let photosViewController = NYTPhotosViewController(photos: self.photos6)
            presentViewController(photosViewController, animated: true, completion: nil)
        default :
            break
        }

    }
   }
