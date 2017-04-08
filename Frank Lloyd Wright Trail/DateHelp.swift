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
    
    static func addSecondsToDate(_ seconds: Int, date: Date) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .second, value: seconds, to: date)!
    }
    
    static func addMinutesToDate(minutes: Int, date: Date) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .minute, value: minutes, to: date)!
    }
    
    static func getStartOfDayFrom(startDate: Date, firstDriveSeconds: Int) -> Date {
        //give 10 minutes wiggle room
        let calendar = Calendar.current
        return calendar.date(byAdding: .second, value: (-firstDriveSeconds - 600), to: startDate)!
    }
    
    static func getDurationOfTour(startTime: Date, endTime: Date) -> Double {
        var interval = endTime.timeIntervalSince(startTime)
        //convert to minutes
        interval = interval/60
        return interval
    }

}
