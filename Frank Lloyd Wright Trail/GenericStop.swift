//
//  GenericStop.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/19/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation

struct GenericStop: Stop {
    var name: String
    var date: Date?{
        didSet{
            if let start = self.startTime{
                self.startDate = CombineDates.combineDateWithTime(self.date!, time: start)
            }else{
                self.startDate = CombineDates.combineDateWithTime(self.date!, time: Date())
            }
            if let end = self.endTime{
                self.endDate = CombineDates.combineDateWithTime(self.date!, time: end)
            }else{
                self.endDate = CombineDates.combineDateWithTime(self.date!, time: Date())
            }
        }
    }
    
    var startTime: Date?{
        didSet{
            if let date = self.date{
                self.startDate = CombineDates.combineDateWithTime(date, time: self.startTime!)
            }else{
                self.startDate = CombineDates.combineDateWithTime(Date(), time: self.startTime!)
            }
        }
    }
    var endTime: Date?{
        didSet{
            if let date = self.date{
                self.endDate = CombineDates.combineDateWithTime(date, time: self.endTime!)
            }else{
                self.endDate = CombineDates.combineDateWithTime(Date(), time: self.endTime!)
            }
        }
    }
    var startDate: Date?
    var endDate: Date?
    
    init(name: String){
        self.name = name
    }
}
