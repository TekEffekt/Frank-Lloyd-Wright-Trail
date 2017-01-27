//
//  CollectionViewCell.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/29/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    @IBOutlet weak var circleColor: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var caption: UILabel!
    
    func makeCircle(){
        let center = circleColor.center
        circleColor.layer.cornerRadius = min(circleColor.frame.size.height, circleColor.frame.size.width) / 2.0
        circleColor.center = center
    }
    func color(title : String){
        switch title {
        case "SC Johnson Administration Building and Research Tower" :
            circleColor.backgroundColor = UIColor.redColor()
        case "Wingspread" :
            circleColor.backgroundColor = UIColor.orangeColor()
        case "Monona Terrace" :
            circleColor.backgroundColor = UIColor.magentaColor()
        case "First Unitatrian Society Meeting House" :
            circleColor.backgroundColor = UIColor.greenColor()
        case "Talisesin and Frank Lloyd Wright Visitor Center" :
            circleColor.backgroundColor = UIColor.blueColor()
        case "A.D. German Warehouse" :
            circleColor.backgroundColor = UIColor.purpleColor()
        case "American System Built Homes" :
            circleColor.backgroundColor = UIColor.cyanColor()
        case "Wyoming Valley School" :
            circleColor.backgroundColor = UIColor.yellowColor()
        default :
            circleColor.backgroundColor = UIColor.redColor()
        }
    }
}
