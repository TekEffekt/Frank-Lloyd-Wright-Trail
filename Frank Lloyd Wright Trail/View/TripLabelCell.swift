//
//  TripLabelCell.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 4/15/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import UIKit

class TripLabelCell: UITableViewCell {

    @IBOutlet weak var tripName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
