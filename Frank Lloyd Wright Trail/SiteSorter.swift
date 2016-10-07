//
//  DistanceSorter.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 9/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//
// This class sorts the cells in the collection view based different criteria like
// based on the distance between the user and the site, 
// the Site's name or by
import Foundation
import CoreLocation

// This class is in charge of sorting the array of Sites by distance, name, and visited sites
class SiteSorter{
    
    // Sorts the sites based on the distance in miles from the user's current location from closests to farthest
    static func sortSitesByDistance(location: CLLocation) -> [Site] {
        let sites = Site.getSites()
        var myNewArray = [Site]()
        
        // manipulating the distance variable of each site so that the distance
        for var site in sites{
            let distanceInMeters = location.distanceFromLocation(CLLocation(latitude: site.lat, longitude: site.lon))
            let num = (distanceInMeters / 1609.344) * 100
            let distanceInMiles = round(num) / 100
            site.distance = distanceInMiles
            myNewArray.append(site)
        }
        
        // sorting the array from closest to farthest
        myNewArray.sortInPlace({ (obj1: Site, obj2: Site) -> Bool in return obj1.distance < obj2.distance })
        
        return myNewArray
    }
}
