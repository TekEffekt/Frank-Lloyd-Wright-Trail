//
//  Stop.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/19/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation

protocol Stop {
    var name : String { get set }
    var date: NSDate? { get set }
    var startTime : NSDate? { get set}
    var endTime: NSDate? { get set }
}

