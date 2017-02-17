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
    let sitesAvailable = Site.getSites()
    var sitesSelected : [Site?]
    var startTime: NSDate?
    var endTime: NSDate?
    var sitesInfo = [TripObject]()
    var stops = [Stop?]()   
    var type : String?
    
    init(){
        let count = sitesAvailable.count
        sitesSelected = Array<Site?>(count: count, repeatedValue: nil)
    }
    
    mutating func addSite(site : Site, index : Int){
        sitesSelected[index]=site
//        print("Added" + "\(site)")
//        print("List = " + "\(sitesSelected.count)")
//        print("\(sitesSelected[index]?.title)")
    }
    
    mutating func removeSite(index : Int){
        //print("Removed" + "\(sitesSelected[index])")
        sitesSelected[index] = nil
        //print("\(sitesSelected[index]?.title)")
    }
    
    func getSites() -> [Site?]{
        return sitesSelected
    }
    
    
    //can't filter until we know user won't press back button
    mutating func filterArray(){
        sitesSelected = sitesSelected.filter{ $0 != nil }
    }
    
}

struct Stop{
    var site : Site?
    var name : String
    var date : NSDate
    var startTime : NSDate
    var endTime : NSDate
}
