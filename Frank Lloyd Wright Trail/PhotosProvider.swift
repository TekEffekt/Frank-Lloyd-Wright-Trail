//
//  PhotosProvider.swift
//  Frank Lloyd Wright Trail
//
//  Created by MichaelHorning on 10/1/16.
//  Copyright © 2016 App Factory. All rights reserved.
//
import UIKit
import NYTPhotoViewer

/**
 *   In Swift 1.2, the following file level constants can be moved inside the class for better encapsulation
 */

let CustomEverythingPhotoIndex = 3, DefaultLoadingSpinnerPhotoIndex = 3, NoReferenceViewPhotoIndex = 4
let PrimaryImageName: String? = nil
let PlaceholderImageName = "NYTimesBuildingPlaceholder"

// creates 6 [ExamplePhoto] and loads it with three correct pictures to be viewed
class PhotosProvider: NSObject {
    
            
    let photos1: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [UIImage(named: "scjohnson")!, UIImage(named:"scjohnson2")!, UIImage(named: "scjohnson3")!]
        var mutablePhotos: [ExamplePhoto] = []
            var image = UIImage(named: "scjohnson")
            let NumberOfPhotos = 3
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title) : ExamplePhoto(attributedCaptionTitle: title)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
            return mutablePhotos
    }()
    
    let photos2: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [UIImage(named: "wingspread")!,UIImage(named: "wingspread2")!, UIImage(named: "wingspread3")!]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 3
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title) : ExamplePhoto(attributedCaptionTitle: title)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()
    let photos3: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [UIImage(named: "mononaterrace")!, UIImage(named: "mononaterrace2")!, UIImage(named: "mononaterrace3")!]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 3
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title) : ExamplePhoto(attributedCaptionTitle: title)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()
    let photos4: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [UIImage(named: "meetinghouse")!, UIImage(named: "meetinghouse2")!, UIImage(named: "meetinghouse3")!]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 3
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title) : ExamplePhoto(attributedCaptionTitle: title)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()
    let photos5: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [UIImage(named: "visitorcenter")!, UIImage(named: "visitorcenter2")!, UIImage(named: "visitorcenter3")!]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 3
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title) : ExamplePhoto(attributedCaptionTitle: title)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()
    let photos6: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [UIImage(named: "warehouse")!, UIImage(named: "warehouse2")!, UIImage(named: "warehouse3")!]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 3
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title) : ExamplePhoto(attributedCaptionTitle: title)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()
    let photos7: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [UIImage(named: "asbh")!, UIImage(named: "asbh2")!, UIImage(named: "asbh3")!]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 3
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title) : ExamplePhoto(attributedCaptionTitle: title)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()
    let photos8: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [UIImage(named: "wyoming")!, UIImage(named: "wyoming2")!, UIImage(named: "wyoming3")!]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 3
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title) : ExamplePhoto(attributedCaptionTitle: title)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()

}

