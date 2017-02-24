//
//  JsonParser.swift
//  Frank Lloyd Wright Trail
//
//  Created by MichaelHorning on 2/3/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import UIKit
import MapKit

protocol TripJsonDelegate: class {
    func getTripData(objects: [TripObject])
}

class JsonParser: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {

    // var to use the usr location
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    // access key for google direction API
    private let key = "AIzaSyD99efuqx7jK3bOi7txWUDRZNlh-G50b0w"
    weak var delegate: TripJsonDelegate!
    
    init(withDelegate delegate: TripJsonDelegate, locations: [Site]) {
        self.delegate = delegate
        super.init()
        orderOfLocations(locations)
    }
    
    // func to create objects to be used for the data for the cards
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
        
        for i in 0..<tripOrder.count {
            time += tripOrder[i].timeValue!/60+60
        }
        if (mealTime > totalTime) {
            
        }else if(mealTime + time > totalTime) {
            //var newTripOrder = tripOrder[0..<tripOrder.capacity-1]
            
        }// else here
    }
    
    // get the lat and long of site and convert to string
    func getLatLong (sites: [Site], index: Int) -> String {
        
        var latLong = String(sites[index].lat) + ","
        latLong += String(sites[index].lon)
        return latLong
        
        
    }
    
    // compares string and image name to return the index
    func findLocation(title: String, sites: [Site])-> Int {
        
        for i in 0..<sites.count {
            
            if(title == sites[i].imageName) {
                return i
            }
        }
        return -1
    }
    
    // takes an array of sites, returns data and order into an array of TripIbjects
    func orderOfLocations(locations: [Site]) -> [TripObject]{
        var startLatLong: String
        var endLatLong: String
        var startLoc: Int
        var endLoc: Int
        var index: Int
        var aLocation: Int
        var bLocation: Int
        var middleLatLong = ""
        //var newLocations: [Site]
        
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
        if(self.currentLocation!.distanceFromLocation(CLLocation(latitude: locationA.lat, longitude: locationA.lon))<self.currentLocation!.distanceFromLocation(CLLocation(latitude: locationB.lat, longitude: locationB.lon))) {
            // user location converted to doubles
            var numLat = Double((self.currentLocation?.coordinate.latitude)!)
            var numLong = Double((self.currentLocation?.coordinate.longitude)!)
            
            // convert the double into a string and add commas where they need to be
            startLatLong = String(numLat) + ","
            startLatLong += String(numLong)
            endLatLong = String(locationB.lat) + ","
            endLatLong += String(locationB.lon)
            endLoc = bLocation
        }
        else {
            // user location converted to doubles
            var numLat = Double((self.currentLocation?.coordinate.latitude)!)
            var numLong = Double((self.currentLocation?.coordinate.longitude)!)
            
            // convert the double into a string and add commas where they need to be
            startLatLong = String(numLat) + ","
            startLatLong += String(numLong)
            endLatLong = String(locationA.lat) + ","
            endLatLong += String(locationA.lon)
            endLoc = aLocation
            
        }
        var j = 0
        for i in 0..<locations.count {
            if(endLoc != i) {
                
                middleLocations.insert(getLatLong(locations, index: i), atIndex: j)
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
        
        
        
        var listOfTrips = [TripObject]()
        let directionURL = "https://maps.googleapis.com/maps/api/directions/json?origin="+startLatLong+"&destination="+endLatLong+"&waypoints=optimize:true%7C"+middleLatLong+"&key=" + key
        let request = NSURLRequest(URL: NSURL(string:directionURL)!)
        let session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request,
                                    completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?)-> Void in
                                        
                                        if error == nil {
                                            do {
                                                let object = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                                                
                                                let routes = object["routes"] as! [NSDictionary]
                                                
                                                for route in routes {
                                                    for i in 0..<route["waypoint_order"]!.count {
                                                        
                                                        var distanceValue = route["legs"]![i]["distance"]!!["value"] as! Int
                                                        var distanceText = route["legs"]![i]["distance"]!!["text"] as! String
                                                        var timeText = route["legs"]![i]["duration"]!!["text"] as! String
                                                        var timeValue = route["legs"]![i]["duration"]!!["value"] as! Int
                                                        var start = String(route["legs"]![i]["start_location"]!!["lat"])
                                                        start += String(route["legs"]![i]["start_location"]!!["lng"])
                                                        var end = String(route["legs"]![i]["end_location"]!!["lat"])
                                                        end += String(route["legs"]![i]["end_location"]!!["lng"])
                                                        var trip = TripObject.init(startPoint: start, endPoint: end, timeText: timeText, timeValue: timeValue, distanceText: distanceText, distanceValue: distanceValue)
                                                        
                                                        listOfTrips.append(trip)
                                                        
                                                    }
                                                }
                                            }catch let error as NSError {
                                                print(error)
                                            }
                                            
                                            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                                                self.delegate?.getTripData(listOfTrips)
                                            })
                                        }
                                        else {
                                            print("Direction API error")
                                        }
                                        
        }).resume()
        return listOfTrips }
}
