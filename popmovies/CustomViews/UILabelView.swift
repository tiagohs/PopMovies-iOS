//
//  UILabel.swift
//  popmovies
//
//  Created by Tiago Silva on 20/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class UILabelView: UILabel {
    
    override func drawText(in rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.stroke(self.bounds.insetBy(dx: 1.0, dy: 1.0))
        super.drawText(in: rect.insetBy(dx: 5.0, dy: 5.0))
    }
}
