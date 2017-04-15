//
//  DateHelp.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 3/26/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

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
    
    static func getStopDictionary(sortedList: List<SiteStop>) -> [Date : [SiteStop]]{
        var siteDict = [Date : [SiteStop]]()
        
        let calendar = Calendar.current
        
        for siteStop in sortedList {
            let month = calendar.component(.month, from: siteStop.date!)
            let day = calendar.component(.day, from: siteStop.date!)
            let year = calendar.component(.year, from: siteStop.date!)
            var components = DateComponents()
            components.month = month
            components.day = day
            components.year = year
            
            let date = calendar.date(from: components)
            if let _ = siteDict[date!] {
                siteDict[date!]?.append(siteStop)
            } else {
                siteDict.updateValue([siteStop], forKey: date!)
            }
        }
        
        return siteDict
        
    }
    
    static func getShortDateName(date: Date) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        let day = calendar.component(.day, from: date)
        
        return dateFormatter.string(from: date) + ", "
    }
    
    static func isInSameDay(_ date1: Date , _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(_: date1, inSameDayAs: date2)
    }

}
