//
//  PolylineParser.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 4/24/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import CoreLocation


class PolylineParser {
    static func parseCoordinates() -> [CLLocationCoordinate2D]? {
        do {
            if let file = Bundle.main.url(forResource: "flw-polyline", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let coordinates = json as? [[String: Any]] else { return nil }
                var coordinateArray = [CLLocationCoordinate2D]()
                for coordinate in coordinates {
                    var coordinate2d = CLLocationCoordinate2D()
                    guard var latitude = coordinate["latitude"] as? Double else { return nil }
                    guard var longitude = coordinate["longitude"] as? Double else { return nil }
                    latitude = latitude.roundTo(places: 5)
                    longitude = longitude.roundTo(places: 5)
                    coordinate2d.latitude = latitude
                    coordinate2d.longitude = longitude
                    coordinateArray.append(coordinate2d)
                }
                return coordinateArray
            } else {
                print("No File")
            }
            
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
