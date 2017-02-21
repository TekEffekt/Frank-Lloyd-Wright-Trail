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
    var date: NSDate?
    var startTime: NSDate?
    var endTime: NSDate?
    var site: Site

    
    init(name: String, site: Site){
        self.name = name
        self.site = site
    }
}
