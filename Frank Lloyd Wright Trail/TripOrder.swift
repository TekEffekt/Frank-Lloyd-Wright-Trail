//
//  TripOrder.swift
//  Frank Lloyd Wright Trail
//
//  Created by MichaelHorning on 11/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class TripObject: Object {
    
    var startPoint: Double?
    var endPoint: Double?
    var timeText: String?
    var timeValue: Double?
    var distanceText: String?
    var distanceValue: Int?
    var image: String?
    
    convenience init(startPoint: Double, endPoint: Double, timeText: String, timeValue: Double, distanceText: String, distanceValue: Int, image: String?) {
        self.init()
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.timeText = timeText
        self.timeValue = timeValue
        self.distanceText = distanceText
        self.distanceValue = distanceValue
        self.image = nil
    }
    
}

