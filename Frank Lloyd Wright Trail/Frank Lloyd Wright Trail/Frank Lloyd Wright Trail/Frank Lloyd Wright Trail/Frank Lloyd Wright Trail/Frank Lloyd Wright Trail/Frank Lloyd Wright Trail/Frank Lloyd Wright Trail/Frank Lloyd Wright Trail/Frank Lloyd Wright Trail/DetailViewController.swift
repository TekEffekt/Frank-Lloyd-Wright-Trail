//
//  DetailViewController.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/23/16.
//  Copyright © 2016 App Factory. All rights reserved.
//
import MapKit
import UIKit

class DetailViewController: UIViewController
{
    @IBAction func siteVisted(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var siteTitle: UILabel!
    @IBOutlet weak var siteDetails: UITextView!
    @IBOutlet weak var siteSubtitle: UILabel!
    
    
    
    
    var viaSegue: MKAnnotationView!
    var sites = Site.getSites()
    
    override func viewDidLoad() {
        displayDetailAnnotation(viaSegue)
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "container" ){
            // segue into DetailViewController and pass through the slected pin's MKPinAnnotaion
            let blank: LocationGalleryPageControlller = segue.destinationViewController as! LocationGalleryPageControlller
            blank.picture = viaSegue
        }
    }
    
    func displayDetailAnnotation (viaSegue: MKAnnotationView){
        
        switch  viaSegue.annotation!.coordinate.latitude{
        case 42.7152375:
            siteDetails.text = sites[0].details
            siteSubtitle.text = sites[0].subtitle
            siteTitle.text = sites[0].title
            
            
        case 42.784472:
            siteDetails.text = sites[1].details
            siteSubtitle.text = sites[1].subtitle
            siteTitle.text = sites[1].title
            
        case 43.0717445:
            siteDetails.text = sites[2].details
            siteSubtitle.text = sites[2].subtitle
            siteTitle.text = sites[2].title
            
        case 43.0757361:
            siteDetails.text = sites[3].details
            siteSubtitle.text = sites[3].subtitle
            siteTitle.text = sites[3].title
            
        case 43.1439006:
            siteDetails.text = sites[4].details
            siteSubtitle.text = sites[4].subtitle
            siteTitle.text = sites[4].title
            
        case 43.3334718:
            siteDetails.text = sites[5].details
            siteSubtitle.text = sites[5].subtitle
            siteTitle.text = sites[5].title
            
        default :
            siteDetails.text = "Not Found"
            siteSubtitle.text = "Not Found"
            siteTitle.text = "Not Found"
        }
        
        
    }
    
}
