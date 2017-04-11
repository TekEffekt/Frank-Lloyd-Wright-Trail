//
//  Network Alert.swift
//  Safety Survey
//
//  Created by Kyle Zawacki on 2/18/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import UIKit

class NetworkAlert {
    
    static func show() {
        OperationQueue.main.addOperation {
            guard let base = UIApplication.shared.keyWindow?.rootViewController else { return }
            
            let controller = UIAlertController(title: "No Internet Connection", message: "You have no internet connection.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default , handler: nil)
            controller.addAction(okAction)
            base.present(controller, animated: true, completion: nil)
        }
    }
    
}
