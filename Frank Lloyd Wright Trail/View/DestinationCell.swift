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
    
}
