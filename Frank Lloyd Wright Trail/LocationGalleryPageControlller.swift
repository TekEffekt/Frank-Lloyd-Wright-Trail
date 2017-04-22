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
class LocationGalleryPageControlller: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, NYTPhotosViewControllerDelegate {
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    // var to take value from segue sent by DetailViewController
    var picture: MKAnnotationView!
    
    var imageControllers: [LocationGalleryImageController] = []
    
    // loads all the sites
    var sites = Site.getSites()
    
    // organize the site photos for displaying
    var site1:[UIImage?] = [#imageLiteral(resourceName: "scjohnson"), #imageLiteral(resourceName: "scjohnson2"), #imageLiteral(resourceName: "scjohnson3"), #imageLiteral(resourceName: "scjohnson4")]
    var site2:[UIImage?] = [#imageLiteral(resourceName: "wingspread"), #imageLiteral(resourceName: "wingspread2"), #imageLiteral(resourceName: "wingspread3"), #imageLiteral(resourceName: "wingspread4"), #imageLiteral(resourceName: "wingspread5")]
    var site4:[UIImage?] = [#imageLiteral(resourceName: "mononaterrace"), #imageLiteral(resourceName: "mononaterrace2"), #imageLiteral(resourceName: "mononaterrace3"), #imageLiteral(resourceName: "mononaterrace4"), #imageLiteral(resourceName: "mononaterrace5"), #imageLiteral(resourceName: "mononaterrace6"), #imageLiteral(resourceName: "mononaterrace7")]
    var site5:[UIImage?] = [#imageLiteral(resourceName: "meetinghouse"), #imageLiteral(resourceName: "meetinghouse2"), #imageLiteral(resourceName: "meetinghouse3"), #imageLiteral(resourceName: "meetinghouse4"), #imageLiteral(resourceName: "meetinghouse5"), #imageLiteral(resourceName: "meetinghouse7")]
    var site6:[UIImage?] = [#imageLiteral(resourceName: "visitorcenter"), #imageLiteral(resourceName: "visitorcenter2"), #imageLiteral(resourceName: "visitorcenter3"), #imageLiteral(resourceName: "visitorcenter4"), #imageLiteral(resourceName: "visitorcenter5"), #imageLiteral(resourceName: "visitorcenter6")]
    var site8:[UIImage?] = [#imageLiteral(resourceName: "warehouse"), #imageLiteral(resourceName: "warehouse2"), #imageLiteral(resourceName: "warehouse3"), #imageLiteral(resourceName: "warehouse4"), #imageLiteral(resourceName: "warehouse5")]
    var site3:[UIImage?] = [#imageLiteral(resourceName: "asbh"), #imageLiteral(resourceName: "asbh2"), #imageLiteral(resourceName: "asbh3"), #imageLiteral(resourceName: "asbh4"), #imageLiteral(resourceName: "asbh5"), #imageLiteral(resourceName: "asbh6"), #imageLiteral(resourceName: "asbh7")]
    var site7:[UIImage?] = [#imageLiteral(resourceName: "wyoming"), #imageLiteral(resourceName: "wyoming2"), #imageLiteral(resourceName: "wyoming3"), #imageLiteral(resourceName: "wyoming4")]

    
    override func viewDidAppear(_ animated: Bool) {
        self.delegate = self
        self.dataSource = self
        // for loop that creates 3 LocationGalleryImageControllers, one for each picture in the sites
        // sets nytphoto to current annotation being view by using its latitude
        for i in 0...6 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "LocationGalleryImageController") as! LocationGalleryImageController
            
            switch  picture.annotation!.coordinate.latitude{
            case 43.3334718:
                if i < site8.count {
                    controller.nytphoto = 43.3334718
                    controller.image = site8[i]
                    imageControllers.append(controller)
                }
            case 43.1439006:
                if i < site7.count {
                    controller.nytphoto = 43.1192397
                    controller.image = site7[i]
                    imageControllers.append(controller)
                }
            case 42.7152375:
                if i < site1.count{
                    controller.nytphoto = 42.7152375
                    controller.image = site1[i]
                    imageControllers.append(controller)
                }
            case 42.784472:
                if i < site2.count {
                    controller.nytphoto = 42.784472
                    controller.image = site2[i]
                    imageControllers.append(controller)
                }
            case 43.0105838:
                if i < site3.count {
                    controller.nytphoto = 43.0105838
                    controller.image = site3[i]
                    imageControllers.append(controller)
                }
            case 43.0717445:
                if i < site4.count {
                    controller.nytphoto = 43.0717445
                    controller.image = site4[i]
                    imageControllers.append(controller)
                }
            case 43.0757361:
                if i < site5.count {
                    controller.nytphoto = 43.0757361
                    controller.image = site5[i]
                    imageControllers.append(controller)
                }
            case 43.1192675:
                if i < site6.count {
                    controller.nytphoto = 43.1439006
                    controller.image = site6[i]
                    imageControllers.append(controller)
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
    
    override func viewDidLoad() {
   
        
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return imageControllers.count
    }
    
    public func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = imageControllers.first, let firstViewControllerIndex = imageControllers.index(of: firstViewController) else {
            return 0
        }
        return firstViewControllerIndex
    }
}

