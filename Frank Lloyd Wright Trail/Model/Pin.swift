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

class Pin: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var lat: Double
    var long: Double
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
        super.init()
    }
    
    // Function that changes the color of the pin
    // Note that there needs to be another method similar to this for older iphone
    // versions since .pinColor has been depricated
    func newPinColor() -> UIColor{
        switch title! {
        case "SC Johnson Administration Building and Research Tower" :
            return UIColor.red
        case "Wingspread" :
            return UIColor.orange
        case "Monona Terrace" :
            return UIColor.magenta
        case "First Unitatrian Society Meeting House" :
            return UIColor.green
        case "Talisesin and Frank Lloyd Wright Visitor Center" :
            return UIColor.blue
        case "A.D. German Warehouse" :
            return UIColor.purple
        case "American System Built Homes" :
            return UIColor.cyan
        case "Wyoming Valley School" :
            return UIColor.yellow
        default :
            return UIColor.red
        }
    }
    
}
