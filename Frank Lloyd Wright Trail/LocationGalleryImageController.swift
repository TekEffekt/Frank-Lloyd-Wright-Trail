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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // UITapGestureRecognizer to display the correct [Example] photo

        let imageTapped = UITapGestureRecognizer(target: self, action: #selector(LocationGalleryImageController.tapped))

        self.galleryImage.addGestureRecognizer(imageTapped)
        if let image = image {
            galleryImage.image = image
        }
    }
    
    func currentPhoto(photo: [ExamplePhoto]) -> Int{
    
        let comparedPhoto = UIImagePNGRepresentation(self.galleryImage.image!)
        for i in 0..<photo.count {
        
            let data = UIImagePNGRepresentation(photo[i].image!)
            if let photoNYT = data, let compareTo = comparedPhoto {
             
                if photoNYT.elementsEqual(compareTo){
                 return i
                }
            }
        }
        return 0
    }
    
    // switch statment to select correct photos
    func tapped(){
        switch  nytphoto!{
        case 43.0105838:
            let index = currentPhoto(photo: photos7)
            let photosViewController = NYTPhotosViewController(photos: photos7, initialPhoto: photos7[index])
            present(photosViewController, animated: true, completion: nil)
        case 43.1192397:
            let index = currentPhoto(photo: photos8)
            let photosViewController = NYTPhotosViewController(photos: photos8, initialPhoto: photos8[index])
            present(photosViewController, animated: true, completion: nil)
        case 42.7152375:
            let index = currentPhoto(photo: photos1)
            let photosViewController = NYTPhotosViewController(photos: photos1, initialPhoto: photos1[index])
            present(photosViewController, animated: true, completion: nil)
        case 42.784472:
            let index = currentPhoto(photo: photos2)
            let photosViewController = NYTPhotosViewController(photos: photos2, initialPhoto: photos2[index])
            present(photosViewController, animated: true, completion: nil)
        case 43.0717445:
            let index = currentPhoto(photo: photos3)
            let photosViewController = NYTPhotosViewController(photos: photos3, initialPhoto: photos3[index])
            present(photosViewController, animated: true, completion: nil)
        case 43.0757361:
            let index = currentPhoto(photo: photos4)
            let photosViewController = NYTPhotosViewController(photos: photos4, initialPhoto: photos4[index])
            present(photosViewController, animated: true, completion: nil)
        case 43.1439006:
            let index = currentPhoto(photo: photos5)
            let photosViewController = NYTPhotosViewController(photos: photos5, initialPhoto: photos5[index])
            present(photosViewController, animated: true, completion: nil)
        case 43.3334718:
            let index = currentPhoto(photo: photos6)
            let photosViewController = NYTPhotosViewController(photos: photos6, initialPhoto: photos6[index])
            present(photosViewController, animated: true, completion: nil)
        default :
            break
        }

    }
   }
