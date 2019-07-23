//
//  Label+Extensions.swift
//  popmovies
//
//  Created by Tiago Silva on 17/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

extension UILabel {
    func setText(_ text: String?, defaultText: String) {
        self.text = text == nil ? defaultText : text
    }
}

extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}
