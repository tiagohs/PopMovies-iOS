//
//  File.swift
//  popmovies
//
//  Created by Tiago Silva on 26/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setText(_ text: String?, defaultText: String) {
        self.text = text == nil ? defaultText : text
    }
}
