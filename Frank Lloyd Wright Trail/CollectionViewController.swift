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
    // array that holds the image and captions for all the cells
//    let items = [Item(caption: "SC Johnson Administration Building", image: "scjohnson"), Item(caption: "Wingspread", image: "wingspread"), Item(caption: "Monona Terrace", image: "mononaterrace"), Item(caption: "First Unitarian Society Meeting House", image: "meetinghouse"), Item(caption: "Talisesin and Frank Lloyd Wright Visiting Center", image: "visitorcenter"), Item(caption: "A.D. German Warehouse", image: "warehouse")]
   
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
        cell.caption.textColor = UIColor.blackColor()
        
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





