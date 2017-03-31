//
//  DateHelp.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 3/26/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation

class DateHelp {
    static func getHoursAndMinutes(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mma"
        return dateFormatter.string(from: date)
    }
    
    static func addHoursToDate(hours: Int, date: Date) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: hours, to: date)!
    }
    
    static func addMinutesToDate(minutes: Int, date: Date) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .minute, value: minutes, to: date)!
    }
    
    static func getStartOfDayFrom(startDate: Date, firstDriveMinutes: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .minute, value: -firstDriveMinutes, to: startDate)!
    }
    
    static func getDurationOfTour(startTime: Date, endTime: Date) -> Double {
        var interval = endTime.timeIntervalSince(startTime)
        //convert to minutes
        interval = interval/60
        return interval
    }

}
