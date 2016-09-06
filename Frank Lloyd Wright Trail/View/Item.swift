//
//  Item.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/29/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import UIKit

class Item: NSObject{
    
    var caption: String?
    var image: UIImage?
    
    init(caption: String, image: String) {
        self.caption = caption
        self.image = UIImage(named: image)
    }
    
    
}