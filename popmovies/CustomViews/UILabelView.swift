//
//  UILabel.swift
//  popmovies
//
//  Created by Tiago Silva on 20/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class UILabelView: UILabel {
    var horizontalPadding = CGFloat(10.0)
    var verticalPadding = CGFloat(10.0)
    
    override func sizeToFit() {
        super.sizeToFit()
        bounds.size.width += 2 * horizontalPadding
        bounds.size.height += 2 * verticalPadding
    }
    
    override func drawText(in rect: CGRect) {
        print(rect)
        super.drawText(in: rect.insetBy(dx: horizontalPadding, dy: verticalPadding))
        invalidateIntrinsicContentSize()
    }
}
