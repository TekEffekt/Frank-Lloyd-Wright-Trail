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

class SiteSorter{
    
    static func sortSitesByDistance(location: CLLocation) -> [Site] {
        let sites = Site.getSites()
        var myNewArray = [Site]()
        for var site in sites{
            let distanceInMeters = location.distanceFromLocation(CLLocation(latitude: site.lat, longitude: site.lon))
            let distanceInMiles = round(distanceInMeters / 1609.344)
            site.distance = distanceInMiles
            myNewArray.append(site)
        }
        
        
        myNewArray.sortInPlace({ (obj1: Site, obj2: Site) -> Bool in return obj1.distance < obj2.distance })
        return myNewArray
    }
}