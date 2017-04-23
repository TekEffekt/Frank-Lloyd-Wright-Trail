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
        siteTitle.adjustsFontSizeToFitWidth = true
        
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
    
    // func to display the right annotaion site info using a switch statment,
    // then setting the correct labels and text view
    func displayDetailAnnotation (_ viaSegue: MKAnnotationView){
        
        switch  viaSegue.annotation!.coordinate.latitude{
        case 42.7152375:
            let plainString = sites[0].details! + "\n\nMore Information \n\nSchedule a Tour \n\nPhone Number: 262-260-2154"
            let attributedString = NSMutableAttributedString(string: plainString)
            let range = (plainString as NSString).range(of: "More Information")
            let webURL = sites[0].infoURL
            attributedString.addAttributes([NSLinkAttributeName: NSURL(string: webURL!)!], range: range)
            let tourRange = (plainString as NSString).range(of: "Schedule a Tour")
            let tourURL = sites[0].website
            attributedString.addAttributes([NSLinkAttributeName: NSURL(string: tourURL!)!], range: tourRange)
            siteDetails.delegate = self
            siteDetails.attributedText = attributedString
            siteDetails.font = UIFont.systemFont(ofSize: 15)
            
            siteSubtitle.text = sites[0].subtitle
            siteTitle.text = sites[0].title
        case 42.784472:
            let plainString = sites[1].details! + "\n\nMore Information \n\nSchedule a Tour \n\nPhone Number: 262-639-3211"
            let attributedString = NSMutableAttributedString(string: plainString)
            let range = (plainString as NSString).range(of: "More Information")
            let webURL = sites[1].infoURL
            attributedString.addAttributes([NSLinkAttributeName: NSURL(string: webURL!)!], range: range)
            let tourRange = (plainString as NSString).range(of: "Schedule a Tour")
            let tourURL = sites[1].website
            attributedString.addAttributes([NSLinkAttributeName: NSURL(string: tourURL!)!], range: tourRange)
            siteDetails.delegate = self
            siteDetails.attributedText = attributedString
            siteDetails.font = UIFont.systemFont(ofSize: 15)
            
            siteSubtitle.text = sites[1].subtitle
            siteTitle.text = sites[1].title
        case 43.0105838:
            let plainString = sites[2].details! + "\n\nMore Information \n\nPhone Number: 608-287-0339 \n"
            let attributedString = NSMutableAttributedString(string: plainString)
            let range = (plainString as NSString).range(of: "More Information")
            let webURL = sites[2].infoURL
            attributedString.addAttributes([NSLinkAttributeName: NSURL(string: webURL!)!], range: range)
            siteDetails.delegate = self
            siteDetails.attributedText = attributedString
            siteDetails.font = UIFont.systemFont(ofSize: 15)
            
            siteSubtitle.text = sites[2].subtitle
            siteTitle.text = sites[2].title
            
        case 43.0717445:
            let plainString = sites[3].details! + "\n\nMore Information \n\nSchedule a Tour \n\nPhone Number: 608-261-4000"
            let attributedString = NSMutableAttributedString(string: plainString)
            let range = (plainString as NSString).range(of: "More Information")
            let webURL = sites[3].infoURL
            attributedString.addAttributes([NSLinkAttributeName: NSURL(string: webURL!)!], range: range)
            let tourRange = (plainString as NSString).range(of: "Schedule a Tour")
            let tourURL = sites[3].website
            attributedString.addAttributes([NSLinkAttributeName: NSURL(string: tourURL!)!], range: tourRange)
            siteDetails.delegate = self
            siteDetails.attributedText = attributedString
            siteDetails.font = UIFont.systemFont(ofSize: 15)
            
            siteSubtitle.text = sites[3].subtitle
            siteTitle.text = sites[3].title
            
        case 43.0757361:
            let plainString = sites[4].details! + "\n\nMore Information \n\nSchedule a Tour \n\nPhone Number: 608-233-9774 \n"
            let attributedString = NSMutableAttributedString(string: plainString)
            let range = (plainString as NSString).range(of: "More Information")
            let webURL = sites[4].infoURL
            attributedString.addAttributes([NSLinkAttributeName: NSURL(string: webURL!)!], range: range)
            let tourRange = (plainString as NSString).range(of: "Schedule a Tour")
            let tourURL = sites[4].website
            attributedString.addAttributes([NSLinkAttributeName: NSURL(string: tourURL!)!], range: tourRange)
            siteDetails.delegate = self
            siteDetails.attributedText = attributedString
            siteDetails.font = UIFont.systemFont(ofSize: 15)
            
            siteSubtitle.text = sites[4].subtitle
            siteTitle.text = sites[4].title
            
        case 43.1192675:
            let plainString = sites[5].details! + "\n\nMore Information \n\nSchedule a Tour \n\nPhone Number: 877-588-7900"
            let attributedString = NSMutableAttributedString(string: plainString)
            let range = (plainString as NSString).range(of: "More Information")
            let webURL = sites[5].infoURL
            if let url = NSURL(string: webURL!) {
            attributedString.addAttributes([NSLinkAttributeName: url], range: range)
            }
            let tourRange = (plainString as NSString).range(of: "Schedule a Tour")
            let tourURL = sites[5].website
            attributedString.addAttributes([NSLinkAttributeName: NSURL(string: tourURL!)!], range: tourRange)
            siteDetails.delegate = self
            siteDetails.attributedText = attributedString
            siteDetails.font = UIFont.systemFont(ofSize: 15)
            
            siteSubtitle.text = sites[5].subtitle
            siteTitle.text = sites[5].title
            
        case 43.1439006:
            let plainString = sites[6].details! + "\n\nMore Information \n\nEmail: WyomingValleySchool@gmail.com \n\nPhone Number: 608-588-2544\n"
            let attributedString = NSMutableAttributedString(string: plainString)
            let range = (plainString as NSString).range(of: "More Information")
            let webURL = sites[6].infoURL
            attributedString.addAttributes([NSLinkAttributeName: NSURL(string: webURL!)!], range: range)
            siteDetails.delegate = self
            siteDetails.attributedText = attributedString
            siteDetails.font = UIFont.systemFont(ofSize: 15)
            
            siteSubtitle.text = sites[6].subtitle
            siteTitle.text = sites[6].title
            
        case 43.3334718:
            let plainString = sites[7].details! + "\n\nMore Information \n\nSchedule a Tour \n\nPhone Number: 608-604-5034 \n"
            let attributedString = NSMutableAttributedString(string: plainString)
            let webRange = (plainString as NSString).range(of: "More Information")
            let webURL = sites[7].infoURL
            attributedString.addAttributes([NSLinkAttributeName: NSURL(string: webURL!)!], range: webRange)
            let tourRange = (plainString as NSString).range(of: "Schedule a Tour")
            let tourURL = sites[7].website
            attributedString.addAttributes([NSLinkAttributeName: NSURL(string: tourURL!)!], range: tourRange)
            siteDetails.delegate = self
            siteDetails.attributedText = attributedString
            siteDetails.font = UIFont.systemFont(ofSize: 15)
            
            siteSubtitle.text = sites[7].subtitle
            siteTitle.text = sites[7].title
            
        default :
            siteDetails.text = "Not Found"
            siteSubtitle.text = "Not Found"
            siteTitle.text = "Not Found"
        }
        
        
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL)
        }
        return true
    }
    
}
