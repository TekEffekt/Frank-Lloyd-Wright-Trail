//
//  RealmDelete.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 3/21/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDelete{
    
    static func deleteTrip(index: Int, trips: Results<Trip>){
        do {
            let realm = try Realm()
            try realm.write{
                realm.delete(trips[index])
            }
        } catch let error {
            print(error)
        }
    }
    
    static func siteStop(index: Int, trip: Trip){
        do {
            let realm = try Realm()
            try realm.write{
                trip.siteStops.remove(objectAtIndex: index)
            }
        } catch let error {
            print(error)
        }
    }
}
