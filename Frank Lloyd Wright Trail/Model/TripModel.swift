//
//  TripModel.swift
//  Frank Lloyd Wright Trail
//  The TripModel struct is used to hold the information that the user selects on the Choose Destination Scene (the sites) and the Trip Time scene (the length of the full trip)
//  Created by Max on 1/29/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation

struct TripModel{
    private var sites = [Site]()
    private var startTime: String
    private var endTime: String
    
    mutating func addSite(site : Site){
        sites.append(site)
//        print("Added" + "\(site)")
//        print("List = " + "\(sites)")
    }
    
    mutating func removeSite(index: Int){
//        print("Removed" + "\(sites[index])")
        if index > 0{
            sites.removeAtIndex(index)
        }
//        print("List = " + "\(sites)")
    }
    
    func getSites() -> Array<Site>{
        return sites
    }
    
    //mutating func editStartTime()
}
