//
//  UITextField+Extensions.swift
//  popmovies
//
//  Created by Tiago Silva on 18/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

extension UITextField {
    
    @IBInspectable var xibPlaceholderLocKey: String? {
        get { return nil }
        set(key) {
            self.placeholder = key?.localized
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
