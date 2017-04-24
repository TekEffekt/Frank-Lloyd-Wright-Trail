//
//  LocationsViewController.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/19/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit
import MapKit

class LocationsViewController: UIViewController, MKMapViewDelegate, LocationCollectionDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationCollectionVc: CollectionViewController!
    let center = CLLocation(latitude: 43.105304, longitude: -89.046729)
    var sites = Site.getSites()
    
    // use this var
    //var parser: JsonParser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        loadPins()
        centerMapOnLocation(center)
        mapView.showsUserLocation = true
        
        
        // use this
        //parser = JsonParser(withDelegate: self, locations: sites)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // setting up the delegate
        locationCollectionVc = childViewControllers.first as! CollectionViewController
        locationCollectionVc.delegate = self
        drawRoute()
    }
    
    
    // use this func to get data and set it
    func getTripData(_ objects: [TripObject]) {
    
    }
    
    func loadPins(){
        for site in sites {
            let annotation = Pin(lat: site.lat.value!, long: site.lon.value!)
            annotation.title = site.title
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        if let customAnnotation = annotation as? Pin {
            // How the pin itself is going to look
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            //Shows title and detail button when user clicks on the pin
            pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            // Color of the pin
            pin.pinTintColor = customAnnotation.newPinColor()
            pin.animatesDrop = true
            pin.canShowCallout = true
            return pin
        }
        return nil
    }
    
    // centers the map on a specific point
    func centerMapOnLocation(_ location : CLLocation){
        let span = MKCoordinateSpanMake(2.0, 2.0)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    // when an annotation is selected map pans into that certain point
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let pin = view.annotation
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: pin!.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            self.performSegue(withIdentifier: "details", sender: view)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //         Get the new view controller using segue.destinationViewController.
        
        if (segue.identifier == "details" ){
            // segue into DetailViewController and pass through the slected pin's MKPinAnnotaion
            let blank = segue.destination as! DetailViewController
            blank.viaSegue = sender as! MKPinAnnotationView
        }
    }
    
    func cellTapped(withSite site: Site) {
        for pin in mapView.annotations {
            if pin.title! == site.title {
                mapView.selectAnnotation(pin, animated: true)
            }
        }
    }
    
    func drawRoute() {
        var locationCoordinateArray = [CLLocationCoordinate2D]()
        for site in sites {
            let lat = site.lat.value!
            let lon = site.lon.value!
            let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            locationCoordinateArray.append(location)
        }
        
        for i in 0..<locationCoordinateArray.count - 1 {
            
            let sourcePlacemark = MKPlacemark(coordinate: locationCoordinateArray[i], addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: locationCoordinateArray[i+1], addressDictionary: nil)
            
            
            let request = MKDirectionsRequest()
            request.source = MKMapItem(placemark: sourcePlacemark)
            request.destination = MKMapItem(placemark: destinationPlacemark)
            request.transportType = .automobile
            
            let directions = MKDirections(request: request)
            
            directions.calculate(completionHandler: { response, error in
                guard error == nil else {
                    print(error!)
                    return
                }
                
                let polyline = response!.routes.first!.polyline
                 self.mapView.add(polyline)
                
            })
        }
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if (overlay is MKPolyline) {
            let pr = MKPolylineRenderer(overlay: overlay)
            pr.strokeColor = UIColor(hexString: "#A6192E")
            pr.lineWidth = 4
            return pr
        }
        return MKPolylineRenderer()
    }
    

}
