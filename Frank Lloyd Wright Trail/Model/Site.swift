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
    let details = ""
    var distance: Double 
    var hasBeenVisited = false
    
    
    static func getSites() -> [Site] {
        var locations: NSArray?
        var sites: [Site] = []
        if let path = NSBundle.mainBundle().pathForResource("locations", ofType: "plist") {
            locations = NSArray(contentsOfFile: path)
        }
        if let items = locations {
            // adds each location to an array of type Pin
            for item in items {
                let lat = item.valueForKey("lat") as! Double
                let long = item.valueForKey("long")as! Double
                let title = item.valueForKey("title") as! String
                let imageName = item.valueForKey("imageName") as! String
                let site = Site(lon: long, lat: lat, title: title, subtitle: "", imageName: imageName, distance: 0.0,hasBeenVisited: false)
                sites.append(site)
            }
        }
        
        return sites
    }
    


}
