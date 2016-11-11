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
    let sites = Site.getSites()
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
        return cell
    }
    // number of cells
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sites.count
    }
    
    
    // Delegate for Collection View
    // ---------------------------
    var selected = false
    // Does something when that cell is clicked
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selected = !selected
        print("Selected item: \(indexPath.row)")
    }
    
    // Flowlayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 15) / 2
        let height = 0.9 * width
        return CGSize(width: width, height: height)
    }

    
//    //3
//    func collectionView(collectionView: UICollectionView,
//                          layout collectionViewLayout: UICollectionViewLayout,
//                                 insetForSectionAt section: Int) -> UIEdgeInsets {
//        return nil
//    }
//    
//    // 4
//    func collectionView(collectionView: UICollectionView,
//                          layout collectionViewLayout: UICollectionViewLayout,
//                                 minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return nil
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
