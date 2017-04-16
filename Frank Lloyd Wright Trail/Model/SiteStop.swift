//
//  SiteStop.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/19/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class SiteStop: Object {
    dynamic var name: String?
    dynamic var startDate: Date?
    dynamic var endDate: Date?
    dynamic var site: Site?
    
    convenience init(name: String, startDate: Date, endDate: Date, site: Site){
        self.init()
        self.name = name
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
