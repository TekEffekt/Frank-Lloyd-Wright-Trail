//
//  RealmWrite.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 3/18/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class RealmWrite {
    
    static func writeTripName(tripName: String, trip: Trip){
        do {
            let realm = try Realm()
            try realm.write {
                trip.tripName = tripName
            }
        } catch let error {
            print(error)
        }
    }
    
    static func writeSiteStopFullStartDate(index: Int, date: Date, trip: Trip) {
        do {
            let realm = try Realm()
            try realm.write {
                trip.siteStops[index].startDate = date
            }
        } catch let error {
            print(error)
        }
    }
    
    static func writeSiteStopFullEndDate(index: Int, date: Date, trip: Trip) {
        do {
            let realm = try Realm()
            try realm.write {
                trip.siteStops[index].endDate = date
            }
        } catch let error {
            print(error)
        }
    }
    
    static func add(siteStop: SiteStop, trip: Trip) {
        do {
            let realm = try Realm()
            try realm.write {
                trip.siteStops.append(siteStop)
            }
        } catch let error {
            print(error)
        }
    }
    
    
    static func add(trip: Trip){
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(trip)
            }
        } catch let error {
            print(error)
        }
    }
    
    static func add(wayPointOrder: String, trip: Trip) {
        do {
            let realm = try Realm()
            try realm.write {
                trip.wayPointOrder = wayPointOrder
            }
        } catch let error {
            print(error)
        }
    }
    static func add(sortedByIndex: String, trip: Trip) {
        do {
            let realm = try Realm()
            try realm.write {
                trip.sortedByIndex = sortedByIndex
            }
        } catch let error {
            print(error)
        }
    }
    
    static func save(complete: Bool, forTrip trip: Trip) {
        do {
            let realm = try Realm()
            try realm.write {
                trip.complete = complete
            }
        } catch let error {
            print(error)
        }
    }
    
    static func add(siteDistance: Double, index: Int, trip: Trip) {
        do {
            let realm = try Realm()
            try realm.write {
                trip.siteStops[index].site?.distance.value! = siteDistance
            }
        } catch let error {
            print(error)
        }
    }
    
    
    
    
}
