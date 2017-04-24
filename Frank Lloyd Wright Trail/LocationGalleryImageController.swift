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
    var statusBarHidden = false
    
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
    
    @IBOutlet weak var galleryImage: UIImageView!
    
    // var to take in image from LocationGalleryPageController
    var image: UIImage?
    // var from LocationGalleryPageController to use for correct site pictures
    var nytphoto: Double?
    
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
        
        switch  nytphoto!{
        case 43.0105838:
            let initialIndex = galleryImage.tag
            let photosViewController = NYTPhotosViewController(photos: self.photos7, initialPhoto: self.photos7[initialIndex])
            present(photosViewController, animated: true, completion: nil)
        case 43.1439006:
            let initialIndex = galleryImage.tag
            let photosViewController = NYTPhotosViewController(photos: self.photos8, initialPhoto: self.photos8[initialIndex])
            present(photosViewController, animated: true, completion: nil)
        case 42.7152375:
            let initialIndex = galleryImage.tag
            let photosViewController = NYTPhotosViewController(photos: self.photos1, initialPhoto: self.photos1[initialIndex])
                present(photosViewController, animated: true, completion: nil)
        case 42.784472:
            let initialIndex = galleryImage.tag
            let photosViewController = NYTPhotosViewController(photos: self.photos2, initialPhoto: self.photos2[initialIndex])
            present(photosViewController, animated: true, completion: nil)
        case 43.0717445:
            let initialIndex = galleryImage.tag
            let photosViewController = NYTPhotosViewController(photos: self.photos3, initialPhoto: self.photos3[initialIndex])
            present(photosViewController, animated: true, completion: nil)
        case 43.0757361:
            let initialIndex = galleryImage.tag
            let photosViewController = NYTPhotosViewController(photos: self.photos4, initialPhoto: self.photos4[initialIndex])
            present(photosViewController, animated: true, completion: nil)
        case 43.1192675:
            let initialIndex = galleryImage.tag
            let photosViewController = NYTPhotosViewController(photos: self.photos5, initialPhoto: self.photos5[initialIndex])
            present(photosViewController, animated: true, completion: nil)
        case 43.3334718:
            let initialIndex = galleryImage.tag
            let photosViewController = NYTPhotosViewController(photos: self.photos6, initialPhoto: self.photos6[initialIndex])
            present(photosViewController, animated: true, completion: nil)
        default :
            break
        }

    }
    
    
   }
