//
//  SimpleItemCell.swift
//  popmovies
//
//  Created by Tiago Silva on 19/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class SimpleItemCell: UICollectionViewCell {
    
    @IBOutlet weak var labelView: UILabel!
    
    var simpleItem: SimpleItem? = nil
    
    func bindSimpleItem(simpleItem: SimpleItem, color: UIColor) {
        self.simpleItem = simpleItem
        
        labelView.text = "  \(String(simpleItem.text))  "
        labelView.textColor = color
        labelView.layer.borderColor = color.cgColor
        labelView.layer.borderWidth = 1.0
        labelView.sizeToFit()
    }
}
