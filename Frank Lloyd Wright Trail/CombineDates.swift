//
//  HelperClasses.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 3/17/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation

class CombineDates {
    
    static func combineDateWithTime(date: NSDate, time: NSDate) -> NSDate?{
        let calendar = NSCalendar.currentCalendar()
        
        let dateComponents = calendar.components([.Year, .Month, .Day], fromDate: date)
        let timeComponenets = calendar.components([.Hour, .Minute, .Second], fromDate: time)
        
        let mergedComponents = NSDateComponents()
        mergedComponents.year = dateComponents.year
        mergedComponents.month = dateComponents.month
        mergedComponents.day = dateComponents.day
        mergedComponents.hour = timeComponenets.hour
        mergedComponents.minute = timeComponenets.minute
        mergedComponents.second = timeComponenets.second
        
        return calendar.dateFromComponents(mergedComponents)
    }
    
    
    
}
