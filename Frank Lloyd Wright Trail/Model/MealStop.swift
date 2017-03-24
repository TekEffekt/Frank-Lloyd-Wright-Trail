//
//  MealStop.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/19/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class MealStop: Object, Stop {
    dynamic var name: String?
    dynamic var date: Date?{
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
    
    dynamic var startTime: Date?{
        didSet{
            if let date = self.date{
                self.startDate = CombineDates.combineDateWithTime(date, time: self.startTime!)
            }else{
                self.startDate = CombineDates.combineDateWithTime(Date(), time: self.startTime!)
            }
        }
    }
    dynamic var endTime: Date?{
        didSet{
            if let date = self.date{
                self.endDate = CombineDates.combineDateWithTime(date, time: self.endTime!)
            }else{
                self.endDate = CombineDates.combineDateWithTime(Date(), time: self.endTime!)
            }
        }
    }
    dynamic var startDate: Date?
    dynamic var endDate: Date?
    
    convenience init(name: String){
        self.init()
        self.name = name
    }
    
}
