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
    func color(_ title : String){
        switch title {
        case "SC Johnson Administration Building & Research Tower" :
            circleColor.backgroundColor = UIColor.red
        case "Wingspread" :
            circleColor.backgroundColor = UIColor.yellow
        case "Monona Terrace" :
            circleColor.backgroundColor = UIColor.orange
        case "First Unitarian Society Meeting House" :
            circleColor.backgroundColor = UIColor.green
        case "Taliesin and Frank Lloyd Wright Visitor Center" :
            circleColor.backgroundColor = UIColor.blue
        case "A.D. German Warehouse" :
            circleColor.backgroundColor = UIColor.purple
        case "American System Built Homes" :
            circleColor.backgroundColor = UIColor.cyan
        case "Wyoming Valley School" :
            circleColor.backgroundColor = UIColor.magenta
        default :
            circleColor.backgroundColor = UIColor.red
        }
    }
}
