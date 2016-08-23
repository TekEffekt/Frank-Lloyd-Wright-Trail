//
//  Site.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/21/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class Site: Object {
    
    dynamic var id = 0
    dynamic var name = ""
    dynamic var image: NSData? = nil
    dynamic var details = ""
    dynamic var lat = 0.0
    dynamic var long = 0.0
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func incrementID() -> Int {
        let realm = try! Realm()
        let nextLocation: NSArray = Array(realm.objects(Site).sorted("id"))
        let last = nextLocation.lastObject
        if nextLocation.count > 0 {
            let currentID = last?.valueForKey("id") as? Int
            return currentID! + 1
        }
        else {
            return 1
        }
    }
}