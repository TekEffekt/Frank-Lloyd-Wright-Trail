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
    var selectedCells = [IndexPath]()
    let sites = Site.getSites()
    var sitesSelected = 0
    var trip = Trip()

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
    
    override func viewWillAppear(_ animated: Bool) {
        let button = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneSelected))
        
        self.navigationItem.rightBarButtonItem = button
        self.navigationItem.title = ""
    }
    
    func doneSelected(_ sender: UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // DataSource for Collection View
    // ---------------------------
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Destination", for: indexPath) as! DestinationCell
        cell.siteImage.image = UIImage(named: sites[indexPath.row].imageName!)
        cell.siteName.text = sites[indexPath.row].title
        cell.selected(false)
        return cell
    }
    // number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sites.count
    }
    
    
    // Delegate for Collection View
    // ---------------------------

    // Does something when that cell is clicked
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("Selected item: \(indexPath.row)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Destination", for: indexPath) as! DestinationCell
        let imageView = cell.siteImage
        visuallySelectSurface(imageView!, withAnimation: true)
        cell.selected(true)
        
        let location = sites[indexPath.row]
        let stop = SiteStop(name: location.title!, site: location)
        trip.siteStops.append(stop)
        for place in trip.siteStops{
            print(place.name)
        }
        sitesSelected += 1
    }
    
    //cells only selectable once
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if self.selectedCells.contains(indexPath){
            return false
        }
        else{
            self.selectedCells.append(indexPath)
            return true
        }
    }
    
    
//    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
//        print ("Deselected item \(indexPath.row)")
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Destination", forIndexPath: indexPath) as! DestinationCell
//        let imageView = cell.siteImage
//        
//        sitesSelected -= 1
//    }
    
    
    // Flowlayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 15) / 2
        let height = 0.9 * width
        return CGSize(width: width, height: height)
    }
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - surface: <#surface description#>
    ///   - animation: <#animation description#>
    func visuallySelectSurface(_ surface: UIImageView, withAnimation animation: Bool) {
        let overlay = UIView(frame: CGRect(x: 0, y: 0,
            width: surface.frame.width, height: surface.frame.height))
        overlay.backgroundColor = UIColor(red:0.20, green:0.55, blue:0.80, alpha:1.0).withAlphaComponent(0.65)
        surface.addSubview(overlay)
        
        let check = UIImageView(image: UIImage(named: "ic_done"))
        check.frame = CGRect(x: overlay.frame.width - 30 - 0.5,
                             y: overlay.frame.height - 30 - 0.5,
                             width: 25, height: 25)
        
        overlay.addSubview(check)
        
        if animation {
            check.transform = CGAffineTransform.identity.scaledBy(x: 0.001, y: 0.001)
            
            UIView.animate(withDuration: 0.3/1.5, delay: 0, options: [], animations: { () -> Void in
                check.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
            }) { (Bool) -> Void in
                UIView.animate(withDuration: 0.3/2, animations: { () -> Void in
                    check.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
                    }, completion: { (Bool) -> Void in
                        check.transform = CGAffineTransform.identity
                })
            }
        }
    }
    
}
