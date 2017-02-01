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
    private var sitesSelected : [Site?] = Array<Site?>(count: 10, repeatedValue: nil)
    private var startTime: String?
    private var endTime: String?
    
    
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
    
    func getSites() -> Array<Site?>{
        return sitesSelected
    }
    
    //can't filter until we know user won't press back button
    mutating func filterArray(){
        sitesSelected = sitesSelected.filter{ $0 != nil }
    }
    
    mutating func editStartTime(time : String){
        startTime = time
    }
    
    mutating func editEndTime(time : String){
        endTime = time
    }
    
    func getStartTime()-> String{
        return startTime!
    }
    
    func getEndTime()->String{
        return endTime!
    }
}
