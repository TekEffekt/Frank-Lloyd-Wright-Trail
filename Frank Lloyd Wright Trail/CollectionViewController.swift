//
//  CollectionControllerViewController.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/31/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit
import CoreLocation

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CLLocationManagerDelegate {
    
    weak var delegate: LocationCollectionDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var milesAway: UILabel!
    var sites: [Site]!
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
        sites = Site.getSites()
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        milesAway.textColor = UIColor.blackColor()
        milesAway.textAlignment = .Right
        milesAway.text = "0 miles away"
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            if let currentlocation = locationManager.location {
                sites = SiteSorter.sortSitesByDistance(currentlocation)
            }
        }
    }
    


    // DataSource for Collection View
    // ---------------------------
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! Cell
        let site = sites[indexPath.row]
        // Sets the caption and image at based on the corresponding object in the array
        cell.image.image = UIImage(named: site.imageName ?? "") ?? UIImage()
        cell.image.backgroundColor = UIColor.redColor()
        cell.caption.text = site.title
        cell.makeCircle()
        cell.color(site.title)
        return cell
    }
    // number of cells
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sites.count
    }

    
    // Delegate for Collection View
    // ---------------------------

    // Does something when that cell is clicked
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let site = sites[indexPath.row]
        milesAway.text! = "\(site.distance) miles away"
        print("\(site.distance) miles away")
        delegate?.cellTapped(withSite: site)
    }
    
}






