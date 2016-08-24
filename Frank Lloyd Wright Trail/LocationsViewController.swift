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

    @IBOutlet weak var mapView: MKMapView!
    
    let madison = CLLocation(latitude: 43.0731, longitude: -89.4012)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self

        // Do any additional setup after loading the view
        
        // The center of the map is going to be Madison
        
        // Add and update the sites into the realm database
        
        centerMapOnLocation(madison)
        loadAnnotations()
        
    }
    
    // Function that will add or update sites into the database
    func addSites(){
        //Populator.addSite(withName: String, withImage: <#T##UIImage#>, withdDetails: <#T##String#>, withLat: <#T##Double#>, withLong: <#T##Double#>)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        if let annotation = annotation as? Location {
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
    
    // A distance measurement in meters from an existing location
    // Aproximately 100 miles
    let radius: CLLocationDistance = 250000
    
    func centerMapOnLocation(location : CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, radius * 2.0, radius)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadAnnotations(){
        // locations
        let scJohnson = CLLocation(latitude: 42.7152375, longitude: -87.7928856)
        let wingspread = CLLocation(latitude: 42.784472, longitude: -87.7737877)
        let mononaTerrace = CLLocation(latitude: 43.0717445, longitude: -89.3825905)
        let meetingHouse = CLLocation(latitude: 43.0757361, longitude: -89.4375255)
        let visitorCenter = CLLocation(latitude: 43.1439006, longitude: -90.0617113)
        let warehouse = CLLocation(latitude: 43.3334718, longitude: -90.3865561)
        
        
        
        // adding each site as a pin onto the map
        // when adding the objects to Realm do it in thise order
        let annotation = Location(id: 1, title: "SC Johnson Administration Building and Research Tower", coordinate: scJohnson.coordinate)
        mapView.addAnnotation(annotation)
        
        let annotation2 = Location(id: 2, title: "Wingspread", coordinate: wingspread.coordinate)
        mapView.addAnnotation(annotation2)
        
        
        let annotation3 = Location(id: 3, title: "Monona Terrace", coordinate: mononaTerrace.coordinate)
        mapView.addAnnotation(annotation3)
        
        let annotation4 = Location(id: 4, title: "First Unitatrian Society Meeting House", coordinate: meetingHouse.coordinate)
        mapView.addAnnotation(annotation4)
        
        let annotation5 = Location(id: 5, title: "Talisesin and Frank Lloyd Wright Visitor Center", coordinate: visitorCenter.coordinate)
        mapView.addAnnotation(annotation5)
        
        let annotation6 = Location(id: 6, title: "A.D. German Warehouse", coordinate: warehouse.coordinate)
        mapView.addAnnotation(annotation6)
        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            performSegueWithIdentifier("details", sender: view)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
     
        if (segue.identifier == "details" ){
                 var blank = segue.destinationViewController as! DetailViewController
        }
    }


}
