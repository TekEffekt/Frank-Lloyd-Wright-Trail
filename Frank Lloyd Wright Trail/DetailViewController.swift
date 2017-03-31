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


class DetailViewController: UIViewController,NYTPhotosViewControllerDelegate, UITextViewDelegate
{
    // button action for visted feature. not implemented yet
    @IBAction func siteVisted(_ sender: AnyObject) {
        
    }
    
    @IBOutlet weak var linkTextView: UITextView!
    // labels and a text view to display site info
    @IBOutlet weak var siteTitle: UILabel!
    @IBOutlet weak var siteDetails: UITextView!
    //@IBOutlet weak var siteSubtitle: UILabel!
    
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "container" ){
            // segue into LocationGalleryPageControlller and pass through the slected pin's MKPinAnnotaion
            let blank: LocationGalleryPageControlller = segue.destination as! LocationGalleryPageControlller
            blank.picture = viaSegue
        }
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    
    func createLinkText(link: String) -> NSMutableAttributedString {

       
        var attributedString = NSMutableAttributedString(string: "")
        let linkAttributes = [
            NSLinkAttributeName: NSURL(string: link),
            NSForegroundColorAttributeName: UIColor.white
            ] as [String : Any]
        switch link {
        case "http://www.scjohnson.com/en/company/visiting.aspx":
             attributedString = NSMutableAttributedString(string: "http://www.scjohnson.com/en/company/visiting.aspx")
        case "http://www.johnsonfdn.org/":
            attributedString = NSMutableAttributedString(string: "http://www.johnsonfdn.org/")
        case "http://www.wrightinmilwaukee.com/":
            attributedString = NSMutableAttributedString(string: "http://www.wrightinmilwaukee.com/")
        case "https://www.mononaterrace.com/":
            attributedString = NSMutableAttributedString(string: "https://www.mononaterrace.com/")
        case "https://www.fusmadison.org/":
            attributedString = NSMutableAttributedString(string: "https://www.fusmadison.org/")
        case "http://www.taliesinpreservation.org/":
            attributedString = NSMutableAttributedString(string: "http://www.taliesinpreservation.org/")
        case "http://wyomingvalleyschool.blogspot.com/":
            attributedString = NSMutableAttributedString(string: "http://wyomingvalleyschool.blogspot.com/")
        case "http://www.adgermanwarehouse.com/index.html":
            attributedString = NSMutableAttributedString(string: "http://www.adgermanwarehouse.com/index.html")
        default:
            attributedString = NSMutableAttributedString(string: "Not found")
        }
    
        
        // Set the 'click here' substring to be the link

        attributedString.setAttributes(linkAttributes, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
    // func to display the right annotaion site info using a switch statment,
    // then setting the correct labels and text view
    func displayDetailAnnotation (_ viaSegue: MKAnnotationView){
        
        switch  viaSegue.annotation!.coordinate.latitude{
        case 42.7152375:
            
            self.linkTextView.delegate = self
            self.linkTextView.attributedText = createLinkText(link: sites[0].subtitle!)
            siteDetails.text = sites[0].details
            siteTitle.text = sites[0].title
        case 42.784472:
            
            self.linkTextView.delegate = self
            self.linkTextView.attributedText = createLinkText(link: sites[1].subtitle!)
            siteDetails.text = sites[1].details
            siteTitle.text = sites[1].title
        case 43.0105838:
            
            self.linkTextView.delegate = self
            self.linkTextView.attributedText = createLinkText(link: sites[2].subtitle!)
            siteDetails.text = sites[2].details
            siteTitle.text = sites[2].title
            
        case 43.0717445:
            
            self.linkTextView.delegate = self
            self.linkTextView.attributedText = createLinkText(link: sites[3].subtitle!)
            siteDetails.text = sites[3].details
            siteTitle.text = sites[3].title
            
        case 43.0757361:
            
            self.linkTextView.delegate = self
            self.linkTextView.attributedText = createLinkText(link: sites[4].subtitle!)
            siteDetails.text = sites[4].details
            siteTitle.text = sites[4].title
            
        case 43.1192675:
            
            self.linkTextView.delegate = self
            self.linkTextView.attributedText = createLinkText(link: sites[5].subtitle!)
            siteDetails.text = sites[5].details
            siteTitle.text = sites[5].title
            
        case 43.1192397:
            
            self.linkTextView.delegate = self
            self.linkTextView.attributedText = createLinkText(link: sites[6].subtitle!)
            siteDetails.text = sites[6].details
            siteTitle.text = sites[6].title
            
        case 43.3334718:
            
            self.linkTextView.delegate = self
            self.linkTextView.attributedText = createLinkText(link: sites[7].subtitle!)
            siteDetails.text = sites[7].details
            siteTitle.text = sites[7].title
            
        default :
            
            siteDetails.text = "Not Found"
            linkTextView.text = "Not Found"
            siteTitle.text = "Not Found"
        }
        
        
    }
    
}
