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
    private let key = "AIzaSyD99efuqx7jK3bOi7txWUDRZNlh-G50b0w"
    var sites = Site.getSites()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        loadPins()
        centerMapOnLocation(center)
        mapView.showsUserLocation = true
        
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

        
        var testSites = [Site]()
        var counter = 4
        var i = 0
        for elements in sites {
            if(i < counter) {
                testSites.append(elements)
                i += 1
            }
            
        
        }
        orderOfLocations(testSites)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // setting up the delegate
        locationCollectionVc = childViewControllers.first as! CollectionViewController
        locationCollectionVc.delegate = self
    }
    
    func loadPins(){
        let sites = Site.getSites()
        for site in sites {
            let annotation = Pin(lat: site.lat, long: site.lon)
            annotation.title = site.title
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        if let customAnnotation = annotation as? Pin {
            // How the pin itself is going to look
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            //Shows title and detail button when user clicks on the pin
            pin.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
            // Color of the pin
            pin.pinTintColor = customAnnotation.newPinColor()
            pin.animatesDrop = true
            pin.canShowCallout = true
            return pin
        }
        return nil
    }
    
    // centers the map on a specific point
    func centerMapOnLocation(location : CLLocation){
        let span = MKCoordinateSpanMake(2.0, 2.0)
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
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            self.performSegueWithIdentifier("details", sender: view)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //         Get the new view controller using segue.destinationViewController.
        
        if (segue.identifier == "details" ){
            // segue into DetailViewController and pass through the slected pin's MKPinAnnotaion
            let blank = segue.destinationViewController as! DetailViewController
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
    
<<<<<<< HEAD
    
    
    
    func createTripPlanner(tripOrder: [TripObject]) {
        
        var breakfast = 3600
        var lunch = 3600
        var dinner = 3600
        var startHour = 9
        var startMin = 30
        var endHour = 7
        var endMin = 30
        var totalTime = 36000
        var time = 0
        var mealTime = dinner + lunch + breakfast
        
        for i in 0...tripOrder.capacity {
            time += tripOrder[i].timeValue!/60+60
        }
        if (mealTime > totalTime) {
            
        }else if(mealTime + time > totalTime) {
            //var newTripOrder = tripOrder[0..<tripOrder.capacity-1]
            
        }// else here
    }
    
    var locManager = CLLocationManager()
    
    func getLatLong (sites: [Site], index: Int) -> String {
        
        var latLong = String(sites[index].lat)
        latLong += String(sites[index].lon)
        return latLong
        
        
    }
    
    func findLocation(title: String, sites: [Site])-> Int {
        
        for i in 0...sites.count - 1 {
            
            if(title == sites[i].imageName) {
                return i
            }
        }
return -1
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
    }
    func orderOfLocations(locations: [Site]) -> [TripObject]{
        var startLatLong: String
        var endLatLong: String
        var startLoc: Int
        var endLoc: Int
        var index: Int
        var aLocation: Int
        var bLocation: Int
        var middleLatLong = ""
        
        var middleLocations = [String]()
        
        index = findLocation("scjohnson", sites: locations)
        if(index == -1)
        {
            index = findLocation("wingspread",sites: locations)
            if(index == -1)
            {
                index = findLocation("builthomes",sites: locations)
                if(index == -1)
                {
                    index = findLocation("meetinghouse", sites: locations)
                    if (index == -1)
                    {
                        index = findLocation("mononaterrace", sites: locations)
                        if (index == -1)
                        {
                            index = findLocation("visitorcenter", sites: locations)
                            if(index == -1){
                                index = findLocation("valleyschool",sites: locations)
                            }
                            if(index == -1){
                                index = findLocation("warehouse",sites: locations)
                            }
                        }
                    }
                }
            }
        }
        
        var locationA = locations[index]
        aLocation = index
        
        
        index = findLocation("warehouse",sites: locations)
        if(index == -1)
        {
            index = findLocation("valleyschool",sites: locations)
            if(index == -1) {
                index = findLocation("visitorcenter", sites: locations)
                if (index == -1) {
                    index = findLocation("meetinghouse", sites: locations)
                    if (index == -1) {
                        index = findLocation("mononaterrace", sites: locations)
                        if (index == -1) {
                            index = findLocation("builthomes",sites: locations)
                            if(index == -1) {
                                index = findLocation("wingspread", sites: locations)
                                if(index == -1) {
                                    index = findLocation("scjohnson", sites: locations)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        var locationB = locations[index]
        bLocation = index
        
        func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])-> CLLocationCoordinate2D {
            var locValue:CLLocationCoordinate2D = manager.location!.coordinate
            return locValue
        }
        
        locManager.requestWhenInUseAuthorization()
        var currentLocation = CLLocation()
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized){
            
            currentLocation = locManager.location!
            
        }
        //var currentLocal
        if(currentLocation.distanceFromLocation(CLLocation(latitude: locationA.lat, longitude: locationA.lon))<currentLocation.distanceFromLocation(CLLocation(latitude: locationB.lat, longitude: locationB.lon))) {
            
            startLatLong = String(locationA.lat) + ","
            startLatLong += String(locationA.lon)
            endLatLong = String(locationB.lat) + ","
            endLatLong += String(locationB.lon)
            startLoc = aLocation
            endLoc = bLocation
        }
        else {
            startLatLong = String(locationB.lat) + ","
            startLatLong += String(locationB.lon)
            endLatLong = String(locationA.lat) + ","
            endLatLong += String(locationA.lon)
            startLoc = bLocation
            endLoc = aLocation
            
        }
        var j = 0
        for i in 0...locations.count {
            if(startLoc != i && endLoc != i) {
                middleLocations[j] = getLatLong(locations, index: i)
                j += 1
            }
        }
        for i in 0...middleLocations.count {
            
            if(i != middleLocations.count-1) {
                
                middleLatLong +=  "," + middleLocations[i] + "%7C"
            } else {
                middleLatLong += middleLocations[i]
            }
        }
        
        
        
        var listOfTrips = [TripObject]()
        let directionURL = "https://maps.googleapis.com/maps/api/directions/json?origin="+startLatLong+"&destination="+endLatLong+"&waypoints=optimize:true"+middleLatLong+"&key=" + key
        let request = NSURLRequest(URL: NSURL(string:directionURL)!)
        let session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request,
                                    completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?)-> Void in
                                        
                                        if error == nil {
                                            do {
                                                let object = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                                                //print(object)
                                                
                                                let routes = object["routes"] as! [NSDictionary]
                                                
                                                for route in routes {
                                                    for i in 0...routes.count - 1{
                                                        var distance = route["legs"]![i]["distance"]!!["value"] as! Int
                                                        var time = route["legs"]![i]["distance"]!!["text"] as! String
                                                        var start = String(route["legs"]![i]["start_location"]!!["lat"])
                                                        start += String(route["legs"]![i]["start_location"]!!["lng"])
                                                        var end = String(route["legs"]![i]["end_location"]!!["lat"])
                                                        end += String(route["legs"]![i]["end_location"]!!["lng"])
                                                        var trip = TripObject.init(startPoint: start, endPoint: end, timeText: time, timeValue: distance)
                                                        listOfTrips.append(trip)
                                                    }
                                                }
                                            }catch let error as NSError {
                                                print(error)
                                            }
                                            
                                            dispatch_async(dispatch_get_main_queue()) {
                                                //update your UI here
                                            }
                                        }
                                        else {
                                            print("Direction API error")
                                        }
                                        
        }).resume()
   return listOfTrips }
=======
>>>>>>> master
}
