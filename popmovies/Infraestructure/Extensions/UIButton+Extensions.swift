//
//  UIButton+Extensions.swift
//  popmovies
//
//  Created by Tiago Silva on 18/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

extension UIButton: XIBLocalizable {
    
    @IBInspectable var isRounded: Bool {
        set {
            if newValue {
                self.layer.cornerRadius = self.bounds.width / 2
            } else {
                self.layer.cornerRadius = 0
            }
        }
        get {
            return false
        }
    }
    
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
    }
    
    @IBInspectable var imageColor: UIColor? {
        get { return nil }
        set(color) {
            guard let imageColor = color else { return }
            
            self.imageView?.setImageColorBy(uiColor: imageColor)
        }
    }
}
