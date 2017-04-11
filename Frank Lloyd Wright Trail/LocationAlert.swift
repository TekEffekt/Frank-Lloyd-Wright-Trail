//
//  LocationAlert.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 4/11/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import UIKit

class LocationAlert {
    
    static func show() {
        OperationQueue.main.addOperation {
            guard let base = UIApplication.shared.keyWindow?.rootViewController else { return }
            
            let alertController = UIAlertController(title: "User Location Access Denied", message: "To allow get a suggested timeline you must enable location services, you may configure it in Settings.", preferredStyle: .alert)
            let settingsButton = UIAlertAction(title: "Settings", style: .default) {
                action -> Void in
                let path = UIApplicationOpenSettingsURLString
                if let settingsURL = URL(string: path), UIApplication.shared.canOpenURL(settingsURL) {
                    UIApplication.shared.openURL(settingsURL)
                }
            }
            alertController.addAction(settingsButton)
            let okButton = UIAlertAction(title: "OK", style: .default) {
                action -> Void in
                return
            }
            alertController.addAction(okButton)
            base.present(alertController, animated: true, completion: nil)
        }
    }
    
}
