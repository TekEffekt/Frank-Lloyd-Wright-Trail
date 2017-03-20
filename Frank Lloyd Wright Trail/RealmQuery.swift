//
//  RealmQuery.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 3/18/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class RealmQuery{
    
    static func queryTrips() -> Results<Trip>? {
        do {
            let realm = try Realm()
            return realm.objects(Trip.self)
        } catch let error {
            print(error)
        }
        return nil
    }
    
}
