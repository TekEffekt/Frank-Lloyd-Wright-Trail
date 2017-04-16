//
//  Trip.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 3/18/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class Trip: Object{
    dynamic var tripName = ""
    dynamic var startTime: Date?
    dynamic var endTime: Date?
    let sitesInfo = List<TripObject>()
    let siteStops = List<SiteStop>()
    dynamic var id = 0
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Trip.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
}
