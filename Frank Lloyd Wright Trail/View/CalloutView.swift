//
//  CalloutView.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 9/6/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit
import MapKit

class CalloutView: MKAnnotationView {
    var label: UILabel
    var button: UIButton
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 

}
