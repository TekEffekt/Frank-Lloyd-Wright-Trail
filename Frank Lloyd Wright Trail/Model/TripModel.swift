//
//  TripModel.swift
//  Frank Lloyd Wright Trail
//  The TripModel struct is used to hold the information that the user selects on the Choose Destination Scene (the sites) and the Trip Time scene (the length of the full trip)
//  Created by Max on 1/29/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation

struct TripModel {
    
    static var shared = TripModel()
    
    var startDate: NSDate?
    var startTime: NSDate?
    var endDate: NSDate?
    var endTime: NSDate?
    var sitesInfo = [TripObject]()
    var stops = [Stop]()
    var type : String?

}


