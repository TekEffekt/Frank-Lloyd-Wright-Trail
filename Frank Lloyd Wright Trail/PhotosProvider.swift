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

let CustomEverythingPhotoIndex = 9, DefaultLoadingSpinnerPhotoIndex = 9, NoReferenceViewPhotoIndex = 9
let PrimaryImageName: String? = nil
let PlaceholderImageName = "NYTimesBuildingPlaceholder"

// creates 6 [ExamplePhoto] and loads it with three correct pictures to be viewed
class PhotosProvider: NSObject {
    
    
    let photos1: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "scjohnson"), #imageLiteral(resourceName: "scjohnson2"), #imageLiteral(resourceName: "scjohnson3"), #imageLiteral(resourceName: "scjohnson4")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 4
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "SC Johnson Administration Building", attributes: [NSForegroundColorAttributeName: UIColor.gray])
            let captionCredit = NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit) : ExamplePhoto(attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit)

            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()
    
    let photos2: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "wingspread"), #imageLiteral(resourceName: "wingspread2"), #imageLiteral(resourceName: "wingspread3"), #imageLiteral(resourceName: "wingspread4"), #imageLiteral(resourceName: "wingspread5")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 5
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "Wingspread", attributes: [NSForegroundColorAttributeName: UIColor.gray])
            let captionCredit = NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit) : ExamplePhoto(attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()
    let photos3: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "mononaterrace"), #imageLiteral(resourceName: "mononaterrace2"), #imageLiteral(resourceName: "mononaterrace3"), #imageLiteral(resourceName: "mononaterrace4"), #imageLiteral(resourceName: "mononaterrace5"), #imageLiteral(resourceName: "mononaterrace6"), #imageLiteral(resourceName: "mononaterrace7")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 7
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "Monona Terrace", attributes: [NSForegroundColorAttributeName: UIColor.gray])
            var captionCredit = NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
            if photoIndex == 6 {
                captionCredit = NSAttributedString(string: "Photo Credit: Sarah Wykhuis", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
            }
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit) : ExamplePhoto(attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()
    let photos4: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "meetinghouse"), #imageLiteral(resourceName: "meetinghouse2"), #imageLiteral(resourceName: "meetinghouse3"), #imageLiteral(resourceName: "meetinghouse4"), #imageLiteral(resourceName: "meetinghouse5"), #imageLiteral(resourceName: "meetinghouse7")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 6
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "First Unitatrian Society Meeting House", attributes: [NSForegroundColorAttributeName: UIColor.gray])
            let captionCredit = NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit) : ExamplePhoto(attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()
    
    let photos5: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "visitorcenter"), #imageLiteral(resourceName: "visitorcenter2"), #imageLiteral(resourceName: "visitorcenter3"), #imageLiteral(resourceName: "visitorcenter4"), #imageLiteral(resourceName: "visitorcenter5"), #imageLiteral(resourceName: "visitorcenter6")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 6
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "Talisesin and Frank Lloyd Wright Visitor Center", attributes: [NSForegroundColorAttributeName: UIColor.gray])
            let captionCredit = NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit) : ExamplePhoto(attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()
    
    let photos6: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "warehouse"), #imageLiteral(resourceName: "warehouse2"), #imageLiteral(resourceName: "warehouse3"), #imageLiteral(resourceName: "warehouse4"), #imageLiteral(resourceName: "warehouse5")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 5
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "A.D. German Warehouse", attributes: [NSForegroundColorAttributeName: UIColor.gray])
            let captionCredit = NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit) : ExamplePhoto(attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()
    
    let photos7: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "asbh"), #imageLiteral(resourceName: "asbh2"), #imageLiteral(resourceName: "asbh3"), #imageLiteral(resourceName: "asbh4"), #imageLiteral(resourceName: "asbh5"), #imageLiteral(resourceName: "asbh6"), #imageLiteral(resourceName: "asbh7")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 7
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "American System Built Homes", attributes: [NSForegroundColorAttributeName: UIColor.gray])
            let captionCredit = NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit) : ExamplePhoto(attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()
    
    let photos8: [ExamplePhoto] = {
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "wyoming"), #imageLiteral(resourceName: "wyoming2"), #imageLiteral(resourceName: "wyoming3"), #imageLiteral(resourceName: "wyoming4")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 4
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "Wyoming Valley School", attributes: [NSForegroundColorAttributeName: UIColor.gray])
            let captionCredit = NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: arrayPic[photoIndex], attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit) : ExamplePhoto(attributedCaptionTitle: title, attributedCaptionSummary: captionSummary, attributedCaptionCredit: captionCredit)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
    }()
    
}

