//
//  FinalAPI.swift
//  Frank Lloyd Wright Trail
//
//  Created by MichaelHorning on 3/24/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import UIKit
import MapKit

protocol FinalAPIDelegate: class {
    func getTripData(_ objects: [TripObject])
}

class FinalAPI: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // var to use the usr location
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    // access key for google direction API
    private let key = "AIzaSyD99efuqx7jK3bOi7txWUDRZNlh-G50b0w"
    weak var delegate: FinalAPIDelegate!
    
    init(withDelegate delegate: FinalAPIDelegate, locations: [Site?]) {
        self.delegate = delegate
        super.init()
        orderOfLocations(locations)
    }
    
    func userLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        
        // if user location is enabled then set currentlocation to user location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            currentLocation = locationManager.location!
        }
    }
    
    
    // get the lat and long of site and convert to string
    func getLatLong (_ sites: [Site?], index: Int) -> String {
        
        var latLong = String(describing: sites[index]!.lat.value!) + ","
        latLong += String(describing: sites[index]!.lon.value!)
        return latLong
        
        
    }
    
    // compares string and image name to return the index
    func findLocation(_ title: String, sites: [Site?])-> Int {
        
        for i in 0..<sites.count {
            
            if(title == sites[i]!.imageName) {
                return i
            }
        }
        return -1
    }
    
    
    //Use this function to retrieve the array of trip objects to create timeline objects from
    // takes an array of sites, returns data and order into an array of TripIbjects
    func orderOfLocations(_ locations2: [Site?]) -> [TripObject]{
        var startLatLong: String
        var endLatLong: String
        var startLoc: Int
        var endLoc: Int
        var index: Int
        var aLocation: Int
        var bLocation: Int
        var middleLatLong = ""
        var locations: [Site?] = []
        for i in 0..<locations2.count {
            if (locations2[i]?.imageName != nil){
                locations.append(locations2[i])
            }
        }
        
        var middleLocations = [String]()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        
        // if user location is enabled then set currentlocation to user location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            currentLocation = locationManager.location!
        }
        
        
        index = findLocation("scjohnson", sites: locations)
        if(index == -1)
        {
            index = findLocation("wingspread",sites: locations)
            if(index == -1)
            {
                index = findLocation("asbh",sites: locations)
                if(index == -1)
                {
                    index = findLocation("mononaterrace", sites: locations)
                    if (index == -1)
                    {
                        index = findLocation("meetinghouse", sites: locations)
                        if (index == -1)
                        {
                            index = findLocation("visitorcenter", sites: locations)
                            if(index == -1){
                                index = findLocation("wyoming",sites: locations)
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
            index = findLocation("wyoming",sites: locations)
            if(index == -1) {
                index = findLocation("visitorcenter", sites: locations)
                if (index == -1) {
                    index = findLocation("meetinghouse", sites: locations)
                    if (index == -1) {
                        index = findLocation("mononaterrace", sites: locations)
                        if (index == -1) {
                            index = findLocation("asbh",sites: locations)
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
        
        
        
        // check the closest location, covert current loction and end location into string
        print("CURRENT LOCATION: \(self.currentLocation.debugDescription)       _)_)_)(()()(")
        if(self.currentLocation!.distance(from: CLLocation(latitude: locationA!.lat.value!, longitude: locationA!.lon.value!))<self.currentLocation!.distance(from: CLLocation(latitude: locationB!.lat.value!, longitude: locationB!.lon.value!))) {
            // user location converted to doubles
            var numLat = Double((self.currentLocation?.coordinate.latitude)!)
            var numLong = Double((self.currentLocation?.coordinate.longitude)!)
            
            // convert the double into a string and add commas where they need to be
            startLatLong = String(numLat) + ","
            startLatLong += String(numLong)
            endLatLong = String(describing: locationB!.lat.value!) + ","
            endLatLong += String(describing: locationB!.lon.value!)
            endLoc = bLocation
        }
        else {
            // user location converted to doubles
            var numLat = Double((self.currentLocation?.coordinate.latitude)!)
            var numLong = Double((self.currentLocation?.coordinate.longitude)!)
            
            // convert the double into a string and add commas where they need to be
            startLatLong = String(numLat) + ","
            startLatLong += String(numLong)
            endLatLong = String(describing: locationA!.lat.value!) + ","
            endLatLong += String(describing: locationA!.lon.value!)
            endLoc = aLocation
            
        }
        var j = 0
        for i in 0..<locations.count {
            if(endLoc != i) {
                
                middleLocations.insert(getLatLong(locations, index: i), at: j)
                j += 1
            }
        }
        for i in 0..<middleLocations.count{
            
            if(i != middleLocations.count) {
                
                middleLatLong += middleLocations[i] + "%7C"
            } else {
                
                middleLatLong += middleLocations[i]
            }
        }
        
        //API uses startLatLong (user location), endLatLong (last site), and middleLatLong, ( all sites inbetween)
        var listOfTrips = [TripObject]()
        
        
        let directionURL = "https://maps.googleapis.com/maps/api/directions/json?origin="+startLatLong+"&destination="+endLatLong+"&waypoints=optimize:true%7C"+middleLatLong+"&key=" + key
        
        let request = URLRequest(url: URL(string:directionURL)!)
        let session = URLSession.shared
        let task = session.dataTask(with: request,
                                    completionHandler: {(data: Data?, response: URLResponse?, error: Error?)-> Void in
                                        
                                        if error == nil {
                                            do {
                                                let object = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                                                
                                                let routes = object["routes"] as! [NSDictionary]
                                                
                                                for route in routes {
                                                    for i in 0...(route["waypoint_order"]! as AnyObject).count {
                                                        let legs = route["legs"] as! NSArray
                                                        let leg = legs[i] as! NSDictionary
                                                        let distanceValue = (leg["distance"] as! NSDictionary)["value"] as! Int
                                                        let distanceText = (leg["distance"] as! NSDictionary)["text"] as! String
                                                        let timeText = (leg["duration"] as! NSDictionary)["text"] as! String
                                                        let timeValue = (leg["duration"] as! NSDictionary)["value"] as! Double
                                                        let start = (leg["start_location"] as! NSDictionary)["lat"] as! Double
                                                        //start += route["legs"]![i]["start_location"]!!["lng"] as! Double
                                                        let end = (leg["end_location"] as! NSDictionary)["lat"] as! Double
                                                        //end += route["legs"]![i]["end_location"]!!["lng"] as! Double
                                                        
                                                        let trip = TripObject.init(startPoint: start, endPoint: end, timeText: timeText, timeValue: timeValue, distanceText: distanceText, distanceValue: distanceValue, image: nil)
                                                        
                                                        listOfTrips.append(trip)
                                                    }
                                                }
                                            }catch let error as NSError {
                                                print(error)
                                            }
                                            
                                            OperationQueue.main.addOperation({
                                                self.delegate?.getTripData(listOfTrips)
                                            })
                                        }
                                        else {
                                            print("Direction API error")
                                        }
                                        
        })
        task.resume()
        return listOfTrips
    }
}
