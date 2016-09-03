//
//  CollectionControllerViewController.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/31/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    weak var delegate: LocationCollectionDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var sites: [Site]!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
        sites = Site.getSites()
    }

    // DataSource
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

    
    // Delegate
    // ---------------------------

    // Does something when that cell is clicked
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let site = sites[indexPath.row]
        delegate?.cellTapped(withSite: site)
    }
    
}






