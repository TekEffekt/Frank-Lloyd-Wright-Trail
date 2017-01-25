//
//  DestinationCell.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 10/21/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class DestinationCell: UICollectionViewCell {
    @IBOutlet weak var siteName: UILabel!
    @IBOutlet weak var siteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let view = UIView()
        view.frame = self.frame
        view.backgroundColor = UIColor.blackColor()
        view.alpha = 0.25
        
        selectedBackgroundView = view
        selectedBackgroundView!.userInteractionEnabled = true
        selectedBackgroundView?.backgroundColor = UIColor(white: 0.7, alpha: 0.9)

        
        self.layer.cornerRadius = 2
    }
    func selected(condition: Bool){
        if condition{
            visuallySelectSurface(siteImage, withAnimation: true)
        }
        else{
            visuallyUnSelectSurface(siteImage)
        }
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - surface: <#surface description#>
    ///   - animation: <#animation description#>
    func visuallySelectSurface(surface: UIImageView, withAnimation animation: Bool) {
        let overlay = UIView(frame: CGRect(x: 0, y: 0,
            width: surface.frame.width, height: surface.frame.height))
        overlay.backgroundColor = UIColor(red:0.20, green:0.55, blue:0.80, alpha:1.0).colorWithAlphaComponent(0.65)
        surface.addSubview(overlay)
        
        let check = UIImageView(image: UIImage(named: "ic_done"))
        check.frame = CGRect(x: overlay.frame.width - 30 - 0.5,
                             y: overlay.frame.height - 30 - 0.5,
                             width: 25, height: 25)
        
        overlay.addSubview(check)
        
        if animation {
            check.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001)
            
            UIView.animateWithDuration(0.3/1.5, delay: 0, options: [], animations: { () -> Void in
                check.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1)
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.3/2, animations: { () -> Void in
                    check.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9)
                    }, completion: { (Bool) -> Void in
                        check.transform = CGAffineTransformIdentity
                })
            }
        }
    }
    
    func visuallyUnSelectSurface(surface: UIImageView) {
        for view in surface.subviews {
            view.removeFromSuperview()
        }
    }
    
}
