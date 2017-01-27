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
        sites = Site.getSites()
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        // Ask for Authorisation from the User
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        milesAway.textAlignment = .Right
        //milesAway.text = "0 miles away"
        milesAway.text = ""
        
        // Gets the current user's current location and passes that location to SiteSorter
        // to get sort the distance from that location to other sites.
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            if let userLocation = locationManager.location {
                sites = SiteSorter.sortSitesByDistance(userLocation)
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
        cell.makeCircle()
        cell.color(site.title)
        // Sets the caption and image at based on the corresponding object in the array
        cell.image.image = UIImage(named: site.imageName ?? "") ?? UIImage()
        cell.image.backgroundColor = UIColor.redColor()
        cell.caption.text = site.title
        
        return cell
    }
    // number of cells
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sites.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 2) / 2
        let height = 0.6 * width
        return CGSizeMake(width, height)
    }
    
    // Delegate for Collection View
    // ---------------------------

    // Does something when that cell is clicked
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let site = sites[indexPath.row]
        
        // Updates the label with the distance from the selected site to the user
        milesAway.text! = "\(site.distance) miles away"
        delegate?.cellTapped(withSite: site)
    }
    

    
    
}






