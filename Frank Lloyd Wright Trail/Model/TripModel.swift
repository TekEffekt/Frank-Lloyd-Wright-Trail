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
    private var breakfastStartTime: String?
    private var breakfastEndTime: String?
    private var lunchStartTime: String?
    private var lunchEndTime: String?
    private var dinnerStartTime: String?
    private var dinnerEndTime: String?
    
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
    
    mutating func editBreakfastStartTime(time : String){
        breakfastStartTime = time
    }
    
    mutating func editBreakfastEndTime(time : String){
        breakfastEndTime = time
    }
    
    mutating func editLunchStartTime(time : String){
        lunchStartTime = time
    }
    
    mutating func editLunchEndTime(time : String){
        lunchEndTime = time
    }
    
    mutating func editDinnerStartTime(time : String){
        dinnerStartTime = time
    }
    
    mutating func editDinnerEndTime(time : String){
        dinnerEndTime = time
    }
}
