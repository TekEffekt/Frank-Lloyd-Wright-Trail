//
//  LocationGalleryPageControlller.swift
//  Frank Lloyd Wright Trail
//
//  Created by MichaelHorning on 9/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit
import MapKit

class LocationGalleryPageControlller: UIPageViewController, UIPageViewControllerDataSource {
    var picture: MKAnnotationView!
    var imageControllers: [LocationGalleryImageController] = []
    let colors = [UIColor.redColor(), UIColor.blueColor(), UIColor.blackColor()]
    var sites = Site.getSites()
    var site1:[UIImage] = [UIImage(named: "scjohnson")!, UIImage(named: "scjohnson2")!, UIImage(named: "scjohnson3")!]
    var site2:[UIImage] = [UIImage(named: "wingspread")!, UIImage(named: "wingspread2")!, UIImage(named: "wingspread3")!]
    var site3:[UIImage] = [UIImage(named: "mononaterrace")!, UIImage(named: "mononaterrace2")!, UIImage(named: "mononaterrace3")!,]
    var site4:[UIImage] = [UIImage(named: "meetinghouse")!, UIImage(named: "meetinghouse2")!, UIImage(named: "meetinghouse3")!]
    var site5:[UIImage] = [UIImage(named: "visitorcenter")!, UIImage(named: "visitorcenter2")!, UIImage(named: "visitorcenter3")!]
    var site6:[UIImage] = [UIImage(named: "warehouse")!, UIImage(named: "warehouse2")!, UIImage(named: "warehouse3")!]
    override func viewDidAppear(animated: Bool) {
        for i in 0...2 {
            let controller = storyboard?.instantiateViewControllerWithIdentifier("LocationGalleryImageController") as! LocationGalleryImageController

            switch  picture.annotation!.coordinate.latitude{
            case 42.7152375:
                controller.image = site1[i]
                imageControllers.append(controller)
            case 42.784472:
            controller.image = site2[i]
                imageControllers.append(controller)
            case 43.0717445:
            controller.image = site3[i]
                imageControllers.append(controller)
            case 43.0757361:
            controller.image = site4[i]
                imageControllers.append(controller)
            case 43.1439006:
            controller.image = site5[i]
                imageControllers.append(controller)
            case 43.3334718:
            controller.image = site6[i]
                imageControllers.append(controller)
            default:break
                
            }

            
            //controller.galleryImage.backgroundColor = UIColor.blueColor()
//            let square = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//            square.backgroundColor = colors[i]
//            controller.view.addSubview(square)
//            imageControllers.append(controller)
        }
        
        if let firstViewController = imageControllers.first {
            setViewControllers([firstViewController],
                               direction: .Forward,
                               animated: true,
                               completion: nil)
        }
        
        self.dataSource = self
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = imageControllers.indexOf(viewController as! LocationGalleryImageController) else {
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
    
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = imageControllers.indexOf(viewController as! LocationGalleryImageController) else {
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
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return imageControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
