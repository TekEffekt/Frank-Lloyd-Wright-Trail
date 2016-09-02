//
//  LocationsViewController.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/19/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit
import MapKit

class LocationsViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    let center = CLLocation(latitude: 43.105304, longitude: -89.046729)
    var annotations: Array = [Pin]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        loadPins()
        centerMapOnLocation(center)
    }
    

    func loadPins(){
        
        
        //load plist file
        
        var locations: NSArray?
        if let path = NSBundle.mainBundle().pathForResource("locations", ofType: "plist") {
            locations = NSArray(contentsOfFile: path)
        }
        if let items = locations {
            // adds each location to an array of type Pin
            for item in items {
                let lat = item.valueForKey("lat") as! Double
                let long = item.valueForKey("long")as! Double
                let annotation = Pin(lat: lat, long: long)
                annotation.title = item.valueForKey("title") as? String
                self.annotations.append(annotation)
            }
            // put the pins on the map
            mapView.addAnnotations(self.annotations)
        }
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        if let annotation = annotation as? Pin {
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            //Shows title and detail button when user clicks on the pin
            pin.canShowCallout = true
            pin.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
            // Color of the pin
            pin.pinTintColor = annotation.newPinColor()
            pin.animatesDrop = true
            return pin
        }
        return nil
        
    }
    
    func panIn(index: Int){
        
        print("Number passed: \(index)")
        print(self.annotations.count)
    }
    
    // centers the map on a specific point
    func centerMapOnLocation(location : CLLocation){
        
        let span = MKCoordinateSpanMake(3.5, 2.0)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    
    // when an annotation is selected map pans into that certain point
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let pin = view.annotation
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: pin!.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    // This is the function that is used when the detail button is pressed it will transition to another view.
//    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        if control == view.rightCalloutAccessoryView {
//            performSegueWithIdentifier("details", sender: view)
//        }
//    }


    



}
