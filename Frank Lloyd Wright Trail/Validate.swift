//
//  Validate.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 4/15/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class Validate {
    
    static func checkMultipleSites(forSite site: Site, inTrip trip: Trip) -> String? {
        var duplicate = ""
        
        for siteStop in trip.siteStops {
            if siteStop.site?.title! == site.title! {
                duplicate = (siteStop.site?.title)!
                return duplicate
            }
        }
        return nil
    }
}
