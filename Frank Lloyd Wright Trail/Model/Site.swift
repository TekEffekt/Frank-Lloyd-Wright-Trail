//
//  Site.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/21/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

struct Site {
    
    let lon: Double
    let lat: Double
    let title: String
    let subtitle: String
    let imageName: String?
    let details: String?
    var distance: Double
    var hasBeenVisited = false
    
    
    static func getSites() -> [Site] {
        var locations: NSArray?
        var sites: [Site] = []
        if let path = Bundle.main.path(forResource: "locations", ofType: "plist") {
            locations = NSArray(contentsOfFile: path)
        }
        if let items = locations {
            // adds each location to an array of type Pin
            for item in items {
                let lat = (item as AnyObject).value(forKey: "lat") as! Double
                let long = (item as AnyObject).value(forKey: "long")as! Double
                let title = (item as AnyObject).value(forKey: "title") as! String
                let imageName = (item as AnyObject).value(forKey: "imageName") as! String
                let subtitle = (item as AnyObject).value(forKey: "subtitle") as! String
                let details = (item as AnyObject).value(forKey: "details") as! String
                let site = Site(lon: long, lat: lat, title: title, subtitle: subtitle, imageName: imageName,details: details,  distance: 0.0,hasBeenVisited: false)
                sites.append(site)
            }
        }
        
        return sites
    }
    
    
    
}
