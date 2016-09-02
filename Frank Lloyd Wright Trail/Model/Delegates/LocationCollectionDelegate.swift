//
//  LocationCollectionDelegate.swift
//  Frank Lloyd Wright Trail
//
//  Created by Kyle Zawacki on 9/2/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

protocol LocationCollectionDelegate: class {
    func cellTapped(withSite site: Site)
}
