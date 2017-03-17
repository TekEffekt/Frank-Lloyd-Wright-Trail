//
//  SiteStop.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/19/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation

struct SiteStop: Stop {
    var name: String
    var date: NSDate?{
        didSet{
            if let start = self.startTime{
                self.startDate = CombineDates.combineDateWithTime(self.date!, time: start)
            }else{
                self.startDate = CombineDates.combineDateWithTime(self.date!, time: NSDate())
            }
            if let end = self.endTime{
                self.endDate = CombineDates.combineDateWithTime(self.date!, time: end)
            }else{
                self.endDate = CombineDates.combineDateWithTime(self.date!, time: NSDate())
            }
        }
    }
    
    var startTime: NSDate?{
        didSet{
            if let date = self.date{
                self.startDate = CombineDates.combineDateWithTime(date, time: self.startTime!)
            }else{
                self.startDate = CombineDates.combineDateWithTime(NSDate(), time: self.startTime!)
            }
        }
    }
    var endTime: NSDate?{
        didSet{
            if let date = self.date{
                self.endDate = CombineDates.combineDateWithTime(date, time: self.endTime!)
            }else{
                self.endDate = CombineDates.combineDateWithTime(NSDate(), time: self.endTime!)
            }
        }
    }
    var startDate: NSDate?
    var endDate: NSDate?
    var site: Site

    
    init(name: String, site: Site){
        self.name = name
        self.site = site
    }
}
