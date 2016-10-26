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
        
        self.layer.cornerRadius = 2
    }
    
}
