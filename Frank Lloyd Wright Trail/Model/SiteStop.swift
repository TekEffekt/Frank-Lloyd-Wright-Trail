//
//  SiteStop.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/19/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class SiteStop: Object, Stop {
    dynamic var name: String?
    dynamic var date: Date?
    dynamic var startTime: Date?
    dynamic var endTime: Date?
    dynamic var startDate: Date?
    dynamic var endDate: Date?
    dynamic var site: Site?
    
    convenience init(name: String, date: Date, startTime: Date, endTime: Date, startDate: Date, endDate: Date, site: Site){
        self.init()
        self.name = name
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.startDate = startDate
        self.endDate = endDate
        self.site = site
    }
    
  
    convenience init(name: String, site: Site){
        self.init()
        self.name = name
        self.site = site
    }
}
