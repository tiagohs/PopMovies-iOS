//
//  UINavigationItem+Extensions.swift
//  popmovies
//
//  Created by Tiago Silva on 22/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

extension UINavigationItem {
    
    @IBInspectable var xibPlaceholderLocKey: String? {
        get { return nil }
        set(key) {
            self.title = key?.localized
        }
    }
    
}
