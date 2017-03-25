//
//  Site.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/21/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class Site: Object{
    
    var lon = RealmOptional<Double>()
    var lat = RealmOptional<Double>()
    dynamic var title: String?
    dynamic var subtitle: String?
    dynamic var imageName: String?
    dynamic var details: String?
    var distance = RealmOptional<Double>()
    dynamic var hasBeenVisited = false
    
    
    
    convenience required init(lon: RealmOptional<Double>, lat: RealmOptional<Double>, title: String, subtitle: String, imageName: String, details: String, distance: RealmOptional<Double>, hasBeenVisited: Bool){
        self.init()
        self.lon = lon
        self.lat = lat
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.details = details
        self.distance = distance
        self.hasBeenVisited = hasBeenVisited
    }
    
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
                let long = (item as AnyObject).value(forKey: "long") as! Double
                let title = (item as AnyObject).value(forKey: "title") as! String
                let imageName = (item as AnyObject).value(forKey: "imageName") as! String
                let subtitle = (item as AnyObject).value(forKey: "subtitle") as! String
                let details = (item as AnyObject).value(forKey: "details") as! String
                let site = Site(lon: RealmOptional(long), lat: RealmOptional(lat), title: title, subtitle: subtitle, imageName: imageName,details: details,  distance: RealmOptional(0.0),hasBeenVisited: false)
                sites.append(site)
            }
        }
        
        return sites
    }
    
    
    
}
