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
    var date: Date? { get set }
    var startTime : Date? { get set}
    var endTime: Date? { get set }
}

