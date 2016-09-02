//
//  CollectionControllerViewController.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/31/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    // array that holds the image and captions for all the cells
    let items = [Item(caption: "SC Johnson Administration Building", image: "scjohnson"), Item(caption: "Wingspread", image: "wingspread"), Item(caption: "Monona Terrace", image: "mononaterrace"), Item(caption: "First Unitarian Society Meeting House", image: "meetinghouse"), Item(caption: "Talisesin and Frank Lloyd Wright Visiting Center", image: "visitorcenter"), Item(caption: "A.D. German Warehouse", image: "warehouse")]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mapView" {
            let destination = segue.destinationViewController as? LocationsViewController
            let indexPath = sender as? NSIndexPath
            let index = indexPath?.row
            destination?.panIn(index!)
        }
    }
    

    // DataSource
    // ---------------------------
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! Cell
        let item = items[indexPath.row]
        // Sets the caption and image at based on the corresponding object in the array
        cell.image.image = item.image
        cell.caption.text = item.caption
        
        return cell
    }
    // number of cells
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    
    // Delegate
    // ---------------------------

    // Does something when that cell is clicked
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Selected \(items[indexPath.row].caption!) at index \(indexPath.row)")
        // work on the seugue
        self.performSegueWithIdentifier("mapView", sender: indexPath)
    }
    
}






