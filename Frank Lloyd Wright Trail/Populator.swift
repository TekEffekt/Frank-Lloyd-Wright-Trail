//
//  Populator.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/22/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class Populator {
    static func addSite(withName name: String, withImage image: NSData, withdDetails details: String, withLat lat: Double, withLong long: Double){
        
        let site = Site()
        site.name = name
        site.image = image
        site.details = details
        site.lat = lat
        site.long = long
        site.id = Site.incrementID()
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(site, update: true)
        }
    }
}