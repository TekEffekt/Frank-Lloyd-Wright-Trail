//
//  HelperClasses.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 3/17/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation

class CombineDates {
    
    static func combineDateWithTime(_ date: Date, time: Date) -> Date?{
        let calendar = Calendar.current
        
        let dateComponents = (calendar as NSCalendar).components([.year, .month, .day], from: date)
        let timeComponenets = (calendar as NSCalendar).components([.hour, .minute, .second], from: time)
        
        var mergedComponents = DateComponents()
        mergedComponents.year = dateComponents.year
        mergedComponents.month = dateComponents.month
        mergedComponents.day = dateComponents.day
        mergedComponents.hour = timeComponenets.hour
        mergedComponents.minute = timeComponenets.minute
        mergedComponents.second = timeComponenets.second
        
        return calendar.date(from: mergedComponents)
    }
    
    
    
}
