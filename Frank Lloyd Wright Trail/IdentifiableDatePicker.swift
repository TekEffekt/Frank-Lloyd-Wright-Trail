//
//  DatePickerExtension.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 4/26/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import UIKit

class IdentifiableDatePicker: UIDatePicker {
    var dateType: DateType = .StartDate
}

enum DateType {
    case StartDate
    case EndDate
}
