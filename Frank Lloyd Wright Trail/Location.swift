//
//  Location.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/23/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import MapKit

// Class so that the pin can change color based on location extends from 
// MKAnnotation

class Location: NSObject, MKAnnotation {
    // Don't really need the name variable
    let name: String
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(name: String, title: String?, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.title = title ?? ""
        self.coordinate = coordinate
        
        super.init()
    }
    
    // Function that changes the color of the pin
    // Note that there needs to be another method similar to this for older iphone
    // versions since .pinColor has been depricated
    func newPinColor() -> UIColor{
        switch title! {
        case "SC Johnson Administration Building and Research Tower" :
            return UIColor.yellowColor()
        case "Wingspread" :
            return UIColor.greenColor()
        case "Monona Terrace" :
            return UIColor.redColor()
        case "First Unitatrian Society Meeting House" :
            return UIColor.purpleColor()
        case "Talisesin and Frank Lloyd Wright Visitor Center" :
            return UIColor.orangeColor()
        case "A.D. German Warehouse" :
            return UIColor.blueColor()
        default :
            return UIColor.redColor()
        }
    }
}
