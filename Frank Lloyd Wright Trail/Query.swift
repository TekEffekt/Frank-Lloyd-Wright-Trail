//
//  Query.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/22/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class Query {
    static func fetchSite(withName: String) -> Site {
        
        let realm = try! Realm()
        let allSites = realm.objects(Site).filter("name = \(withName)")
        return Array(allSites).first!
        
    }
    
    static func fetchSite(withId id: Int) -> Site {
        let realm = try! Realm()
        let sites = realm.objects(Site).filter("id = \(id)")
        return Array(sites).first!
    }
}