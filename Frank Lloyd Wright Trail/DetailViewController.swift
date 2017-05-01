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
    //var viaSegue: MKAnnotationView!
    var indexTapped: Int!
    
    // var to contain all the sites from Site in Delegates folder
    var sites = Site.getSites()
    
    
    override func viewDidLoad() {
        
        displayDetailAnnotation(indexTapped)
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
            blank.indexTapped = indexTapped
        }
    }
    
    // func to display the right annotaion site info using a switch statment,
    // then setting the correct labels and text view
    func displayDetailAnnotation(_ indexTapped: Int){
        if indexTapped == 2 {
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
        } else if indexTapped == 6 {
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
        } else {
            let phoneNumber = sites[indexTapped].phoneNumber
            let plainString = sites[indexTapped].details! + "\n\nMore Information \n\nSchedule a Tour \n\nPhone Number: \(String(describing: phoneNumber))"
            let attributedString = NSMutableAttributedString(string: plainString)
            let range = (plainString as NSString).range(of: "More Information")
            let webURL = sites[indexTapped].infoURL
            attributedString.addAttributes([NSLinkAttributeName: NSURL(string: webURL!)!], range: range)
            let tourRange = (plainString as NSString).range(of: "Schedule a Tour")
            let tourURL = sites[indexTapped].website
            attributedString.addAttributes([NSLinkAttributeName: NSURL(string: tourURL!)!], range: tourRange)
            siteDetails.delegate = self
            siteDetails.attributedText = attributedString
            siteDetails.font = UIFont.systemFont(ofSize: 15)
            
            siteSubtitle.text = sites[indexTapped].subtitle
            siteTitle.text = sites[indexTapped].title
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
