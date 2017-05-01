//
//  LocationGalleryPageControlller.swift
//  Frank Lloyd Wright Trail
//
//  Created by MichaelHorning on 9/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit
import MapKit
import NYTPhotoViewer
class LocationGalleryPageControlller: UIPageViewController, UIPageViewControllerDataSource, NYTPhotosViewControllerDelegate {

    // var to take value from segue sent by DetailViewController
    //var picture: MKAnnotationView!
    var indexTapped: Int!
    
    var imageControllers: [LocationGalleryImageController] = []
    
    // loads all the sites
    var sites = Site.getSites()
    
    var photoDictionary: [Int : [UIImage]] = [
        0 : [#imageLiteral(resourceName: "scjohnson"), #imageLiteral(resourceName: "scjohnson2"), #imageLiteral(resourceName: "scjohnson3")],
        1 : [#imageLiteral(resourceName: "wingspread"), #imageLiteral(resourceName: "wingspread2"), #imageLiteral(resourceName: "wingspread3")],
        2 : [#imageLiteral(resourceName: "asbh"), #imageLiteral(resourceName: "asbh2"), #imageLiteral(resourceName: "asbh3"), #imageLiteral(resourceName: "asbh4")
            , #imageLiteral(resourceName: "asbh5")],
        3 : [#imageLiteral(resourceName: "mononaterrace"), #imageLiteral(resourceName: "mononaterrace2"), #imageLiteral(resourceName: "mononaterrace3"), #imageLiteral(resourceName: "mononaterrace4")],
        4 : [#imageLiteral(resourceName: "meetinghouse"), #imageLiteral(resourceName: "meetinghouse2"), #imageLiteral(resourceName: "meetinghouse3")],
        5 : [#imageLiteral(resourceName: "visitorcenter"), #imageLiteral(resourceName: "visitorcenter2"), #imageLiteral(resourceName: "visitorcenter3")],
        6 : [#imageLiteral(resourceName: "wyoming"), #imageLiteral(resourceName: "wyoming2"), #imageLiteral(resourceName: "wyoming3")],
        7 : [#imageLiteral(resourceName: "warehouse"), #imageLiteral(resourceName: "warehouse2"), #imageLiteral(resourceName: "warehouse3")]
    ]
    
    override func viewDidLoad() {
        let index = Int(indexTapped)
        for image in photoDictionary[index]! {
            let controller = storyboard?.instantiateViewController(withIdentifier: "LocationGalleryImageController") as! LocationGalleryImageController
            controller.indexTapped = indexTapped
            controller.image = image
            imageControllers.append(controller)
        }
        
        if let firstViewController = imageControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: false,
                               completion: nil)
        }
        
        self.dataSource = self
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = imageControllers.index(of: viewController as! LocationGalleryImageController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard imageControllers.count > previousIndex else {
            return nil
        }
        
        return imageControllers[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = imageControllers.index(of: viewController as! LocationGalleryImageController) else {
            return nil
        }
        
        imageControllers[viewControllerIndex].galleryImage.tag = viewControllerIndex
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = imageControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return imageControllers[nextIndex]
    }
    
}

