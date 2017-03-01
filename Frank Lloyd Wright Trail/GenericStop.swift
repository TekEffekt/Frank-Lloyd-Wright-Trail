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
    var date: NSDate?
    var startTime: NSDate?
    var endTime: NSDate?
    
    init(name: String){
        self.name = name
    }
}
