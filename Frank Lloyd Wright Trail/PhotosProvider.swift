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
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "scjohnson"), #imageLiteral(resourceName: "scjohnson2"), #imageLiteral(resourceName: "scjohnson3")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 3
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "SC Johnson Administration Building", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "SC Johnson – Iconic architecture, inspiring tours", attributes: [NSForegroundColorAttributeName: UIColor.gray])
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
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "wingspread"), #imageLiteral(resourceName: "wingspread2"), #imageLiteral(resourceName: "wingspread3")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 3
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "Wingspread", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "Wingspread designed for SC Johnson owner Herbert Fisk Johnson, Jr. in 1936", attributes: [NSForegroundColorAttributeName: UIColor.gray])
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
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "mononaterrace"), #imageLiteral(resourceName: "mononaterrace2"), #imageLiteral(resourceName: "mononaterrace3"), #imageLiteral(resourceName: "mononaterrace4")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 4
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "Monona Terrace", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "Monona Terrace completed in 1997", attributes: [NSForegroundColorAttributeName: UIColor.gray])
            var captionCredit = NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
            if photoIndex == 3 {
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
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "meetinghouse"), #imageLiteral(resourceName: "meetinghouse2"), #imageLiteral(resourceName: "meetinghouse3")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 3
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "First Unitatrian Society Meeting House", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "A landmark in church architecture from 1951", attributes: [NSForegroundColorAttributeName: UIColor.gray])
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
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "visitorcenter"), #imageLiteral(resourceName: "visitorcenter2"), #imageLiteral(resourceName: "visitorcenter3")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 3
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "Talisesin and Frank Lloyd Wright Visitor Center", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "Wright’s home, studio, school, and 800-acre agricultural estate", attributes: [NSForegroundColorAttributeName: UIColor.gray])
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
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "warehouse"), #imageLiteral(resourceName: "warehouse2"), #imageLiteral(resourceName: "warehouse3")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 3
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "A.D. German Warehouse", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "300 South Church Street – 1917-1921", attributes: [NSForegroundColorAttributeName: UIColor.gray])
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
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "asbh"), #imageLiteral(resourceName: "asbh2"), #imageLiteral(resourceName: "asbh3"), #imageLiteral(resourceName: "asbh4"), #imageLiteral(resourceName: "asbh5")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 5
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "American System Built Homes", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "Variously built between 1915 and 1917", attributes: [NSForegroundColorAttributeName: UIColor.gray])
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
        var arrayPic: [UIImage] = [#imageLiteral(resourceName: "wyoming"), #imageLiteral(resourceName: "wyoming2"), #imageLiteral(resourceName: "wyoming3")]
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: "scjohnson")
        let NumberOfPhotos = 3
        
        func shouldSetImageOnIndex(_ photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< arrayPic.capacity {
            let title = NSAttributedString(string: "Wyoming Valley School", attributes: [NSForegroundColorAttributeName: UIColor.white])
            let captionSummary = NSAttributedString(string: "Designed by Frank Lloyd Wright and built in 1957 for the children of Wyoming Valley", attributes: [NSForegroundColorAttributeName: UIColor.gray])
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

