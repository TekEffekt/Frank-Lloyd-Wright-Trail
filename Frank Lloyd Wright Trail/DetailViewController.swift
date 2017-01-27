//
//  DetailViewController.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/23/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import MapKit
import UIKit
import NYTPhotoViewer

class DetailViewController: UIViewController,NYTPhotosViewControllerDelegate
{
    // button action for visted feature. not implemented yet
    @IBAction func siteVisted(sender: AnyObject) {
        
    }
    
    // labels and a text view to display site info
    @IBOutlet weak var siteTitle: UILabel!
    @IBOutlet weak var siteDetails: UITextView!
    @IBOutlet weak var siteSubtitle: UILabel!
    
    // var to take in annoation from LocationsViewController
    var viaSegue: MKAnnotationView!
    
    // var to contain all the sites from Site in Delegates folder
    var sites = Site.getSites()
    
    
    override func viewDidLoad() {
        
        displayDetailAnnotation(viaSegue)
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    // a segue to pass along the annotation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "container" ){
            // segue into LocationGalleryPageControlller and pass through the slected pin's MKPinAnnotaion
            let blank: LocationGalleryPageControlller = segue.destinationViewController as! LocationGalleryPageControlller
            blank.picture = viaSegue
        }
    }
    
    // func to display the right annotaion site info using a switch statment,
    // then setting the correct labels and text view
    func displayDetailAnnotation (viaSegue: MKAnnotationView){
        
        switch  viaSegue.annotation!.coordinate.latitude{
        case 43.1192397:
            siteDetails.text = sites[0].details
            siteSubtitle.text = sites[0].subtitle
            siteTitle.text = sites[0].title
        case 43.0105838:
            siteDetails.text = sites[1].details
            siteSubtitle.text = sites[1].subtitle
            siteTitle.text = sites[1].title
        case 42.7152375:
            siteDetails.text = sites[2].details
            siteSubtitle.text = sites[2].subtitle
            siteTitle.text = sites[2].title
            
        case 42.784472:
            siteDetails.text = sites[3].details
            siteSubtitle.text = sites[3].subtitle
            siteTitle.text = sites[3].title
            
        case 43.0717445:
            siteDetails.text = sites[4].details
            siteSubtitle.text = sites[4].subtitle
            siteTitle.text = sites[4].title
            
        case 43.0757361:
            siteDetails.text = sites[5].details
            siteSubtitle.text = sites[5].subtitle
            siteTitle.text = sites[5].title
            
        case 43.1439006:
            siteDetails.text = sites[6].details
            siteSubtitle.text = sites[6].subtitle
            siteTitle.text = sites[6].title
            
        case 43.3334718:
            siteDetails.text = sites[7].details
            siteSubtitle.text = sites[7].subtitle
            siteTitle.text = sites[7].title
            
        default :
            siteDetails.text = "Not Found"
            siteSubtitle.text = "Not Found"
            siteTitle.text = "Not Found"
        }
        
        
    }
    
}
