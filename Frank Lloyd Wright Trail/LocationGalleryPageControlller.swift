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
    var picture: MKAnnotationView!
    
    var imageControllers: [LocationGalleryImageController] = []
    
    // loads all the sites
    var sites = Site.getSites()
    
    // organize the site photos for displaying
    var site1:[UIImage?] = [#imageLiteral(resourceName: "scjohnson"), #imageLiteral(resourceName: "scjohnson2"), #imageLiteral(resourceName: "scjohnson3")]
    var site2:[UIImage?] = [#imageLiteral(resourceName: "wingspread"), #imageLiteral(resourceName: "wingspread2"), #imageLiteral(resourceName: "wingspread3")]
    var site4:[UIImage?] = [#imageLiteral(resourceName: "mononaterrace"), #imageLiteral(resourceName: "mononaterrace2"), #imageLiteral(resourceName: "mononaterrace3"), #imageLiteral(resourceName: "mononaterrace4")]
    var site5:[UIImage?] = [#imageLiteral(resourceName: "meetinghouse"), #imageLiteral(resourceName: "meetinghouse2"), #imageLiteral(resourceName: "meetinghouse3")]
    var site6:[UIImage?] = [#imageLiteral(resourceName: "visitorcenter"), #imageLiteral(resourceName: "visitorcenter2"), #imageLiteral(resourceName: "visitorcenter3")]
    var site8:[UIImage?] = [#imageLiteral(resourceName: "warehouse"), #imageLiteral(resourceName: "warehouse2"), #imageLiteral(resourceName: "warehouse3")]
    var site3:[UIImage?] = [#imageLiteral(resourceName: "asbh"), #imageLiteral(resourceName: "asbh2"), #imageLiteral(resourceName: "asbh3"), #imageLiteral(resourceName: "asbh4")
        , #imageLiteral(resourceName: "asbh5")]
    var site7:[UIImage?] = [#imageLiteral(resourceName: "wyoming"), #imageLiteral(resourceName: "wyoming2"), #imageLiteral(resourceName: "wyoming3")]

    
    override func viewDidAppear(_ animated: Bool) {
        
        // for loop that creates 3 LocationGalleryImageControllers, one for each picture in the sites
        // sets nytphoto to current annotation being view by using its latitude
        for i in 0...4 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "LocationGalleryImageController") as! LocationGalleryImageController
            
            switch  picture.annotation!.coordinate.latitude{
            case 43.3334718:
                if i < site8.count {
                    if site8[i] != nil {
                        controller.nytphoto = 43.3334718
                        controller.image = site8[i]
                        imageControllers.append(controller)
                    }
                }
            case 43.1439006:
                if i < site7.count {
                    if site7[i] != nil {
                        controller.nytphoto = 43.1439006
                        controller.image = site7[i]
                        imageControllers.append(controller)
                    }
                }
            case 42.7152375:
                if i < site1.count {
                    if site1[i] != nil {
                        controller.nytphoto = 42.7152375
                        controller.image = site1[i]
                        imageControllers.append(controller)
                    }
                }
            case 42.784472:
                if i < site2.count {
                    if site2[i] != nil {
                        controller.nytphoto = 42.784472
                        controller.image = site2[i]
                        imageControllers.append(controller)
                    }
                }
            case 43.0105838:
                if i < site3.count {
                    if site3[i] != nil {
                        controller.nytphoto = 43.0105838
                        controller.image = site3[i]
                        imageControllers.append(controller)
                    }
                }
            case 43.0717445:
                if i < site4.count {
                    if site4[i] != nil {
                        controller.nytphoto = 43.0717445
                        controller.image = site4[i]
                        imageControllers.append(controller)
                    }
                }
            case 43.0757361:
                if i < site5.count {
                    if site5[i] != nil {
                        controller.nytphoto = 43.0757361
                        controller.image = site5[i]
                        imageControllers.append(controller)
                    }
                }
            case 43.1192675:
                if i < site6.count {
                    if site6[i] != nil {
                        controller.nytphoto = 43.1192675
                        controller.image = site6[i]
                        imageControllers.append(controller)
                    }
                }
            default:
                break
                
            }
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

