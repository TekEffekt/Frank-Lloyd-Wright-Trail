//
//  GenericStop.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/19/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class GenericStop: Object, Stop {
    dynamic var name: String?
    dynamic var date: Date?
    dynamic var startTime: Date?
    dynamic var endTime: Date?
    dynamic var startDate: Date?
    dynamic var endDate: Date?
    
    convenience init(name: String){
        self.init()
        self.name = name
    }
}
