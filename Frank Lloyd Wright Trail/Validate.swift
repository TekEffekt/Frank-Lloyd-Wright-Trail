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
        //check for duplicate sites
        var duplicate = ""
        
        for siteStop in trip.siteStops {
            if siteStop.site?.title! == site.title! {
                duplicate = (siteStop.site?.title)!
                return duplicate
            }
        }
        return nil
    }
    
    static func tripTimes(forTrip trip: Trip) -> String? {
        //check to make sure trip has both times assigned, and that start time isn't after end time
        guard let tripStartTime = trip.startTime else { return "You have not selected a trip start time." }
        guard let tripEndTime = trip.endTime else { return "You have not selected a trip end time." }
        
        if tripStartTime.isGreaterThanDate(tripEndTime) {
            return "The selected trip start time is after the trip end time."
        }
        return nil
    }
    
    static func siteStops(forTrip trip: Trip) -> String? {
        
        for siteStop in trip.siteStops {
            guard let siteStartDate = siteStop.startDate else {
                return "\(siteStop.name!)'s tour has no start date."
            }
            
            guard let siteEndDate = siteStop.endDate else {
                return "\(siteStop.name!)'s tour has no end date."
            }
            
            if siteStartDate.isGreaterThanDate(siteEndDate) {
                return "\(siteStop.name!)'s tour start time is after the end time."
            }
            
            if !DateHelp.isInSameDay(siteStartDate, siteEndDate) {
                return "\(siteStop.name!)'s tour start date and end date must be on the same day"
            }
        }
        
        return nil
        
    }
}
