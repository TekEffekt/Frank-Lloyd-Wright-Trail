//
//  ChooseDestinationVC.swift
//  Frank Lloyd Wright Trail
// 
//  Created by Alex on 10/21/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class ChooseDestinationVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var continueButton: UIButton!
    
    let sites = Site.getSites()
    var sitesSelected = 0
    var parser = JsonParser()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
        
        let width = (collectionView.bounds.width - 45) / 2
        let height = 0.9 * width
        layout.itemSize = CGSize(width: width, height: height)

        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        
        collectionView.allowsMultipleSelection = true
        sitesSelected = 0
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // DataSource for Collection View
    // ---------------------------
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Destination", forIndexPath: indexPath) as! DestinationCell
        cell.siteImage.image = UIImage(named: sites[indexPath.row].imageName!)
        cell.siteName.text = sites[indexPath.row].title
        cell.selected(false)
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
        print("Selected item: \(indexPath.row)")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Destination", forIndexPath: indexPath) as! DestinationCell
        let imageView = cell.siteImage
        visuallySelectSurface(imageView, withAnimation: true)
        TripModel.shared.addSite(sites[indexPath.row], index: indexPath.row)
        sitesSelected += 1
        disableButton()
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print ("Deselected item \(indexPath.row)")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Destination", forIndexPath: indexPath) as! DestinationCell
        let imageView = cell.siteImage
        TripModel.shared.removeSite(indexPath.row)
        visuallyUnSelectSurface(imageView)
        sitesSelected -= 1
        disableButton()
    }
    
    
    // Flowlayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 15) / 2
        let height = 0.9 * width
        return CGSize(width: width, height: height)
    }
    
    func disableButton(){
        if sitesSelected == 0 {
            continueButton.enabled = false
        }
        else {
            continueButton.enabled = true
        }
    }

    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - surface: <#surface description#>
    ///   - animation: <#animation description#>
    func visuallySelectSurface(surface: UIImageView, withAnimation animation: Bool) {
        let overlay = UIView(frame: CGRect(x: 0, y: 0,
            width: surface.frame.width, height: surface.frame.height))
        overlay.backgroundColor = UIColor(red:0.20, green:0.55, blue:0.80, alpha:1.0).colorWithAlphaComponent(0.65)
        surface.addSubview(overlay)
        
        let check = UIImageView(image: UIImage(named: "ic_done"))
        check.frame = CGRect(x: overlay.frame.width - 30 - 0.5,
                             y: overlay.frame.height - 30 - 0.5,
                             width: 25, height: 25)
        
        overlay.addSubview(check)
        
        if animation {
            check.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001)
            
            UIView.animateWithDuration(0.3/1.5, delay: 0, options: [], animations: { () -> Void in
                check.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1)
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.3/2, animations: { () -> Void in
                    check.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9)
                    }, completion: { (Bool) -> Void in
                        check.transform = CGAffineTransformIdentity
                })
            }
        }
    }
    
    func visuallyUnSelectSurface(surface: UIImageView) {
        for view in surface.subviews {
            view.removeFromSuperview()
        }
    }
    
    @IBAction func `continue`(sender: AnyObject) {
        //remove nil sites so can send actual values into parse method
        let sites: [Site?] = TripModel.shared.getSites()
        var array: [Site] = []
        for s in sites{
            if(s != nil){
                array.append(s!)
            }
        }
        parser.userLocation()
        TripModel.shared.setTripInfo(parser.orderOfLocations(array))
        print("\(TripModel.shared.getSitesInfo())")
    }
    
}
