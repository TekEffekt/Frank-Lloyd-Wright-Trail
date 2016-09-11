//
//  CalloutView.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 9/6/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class CalloutView: UIView {
    
    class MapPinCallout: UIView {
        override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
            let viewPoint = superview?.convertPoint(point, toView: self) ?? point
            
            let isInsideView = pointInside(viewPoint, withEvent: event)
            
            var view = super.hitTest(viewPoint, withEvent: event)
            
            return view
        }
        
        override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
            return CGRectContainsPoint(bounds, point)
        }
    }
    
}
