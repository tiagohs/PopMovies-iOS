//
//  SimpleItemCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class SimpleItemCell: UICollectionViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    
    var simpleItem: SimpleItem? {
        didSet { bindSimpleItem(self.simpleItem!)}
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                contentView.leftAnchor.constraint(equalTo: leftAnchor),
                contentView.rightAnchor.constraint(equalTo: rightAnchor),
                contentView.topAnchor.constraint(equalTo: topAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func bindSimpleItem(_ simpleItem: SimpleItem) {
        itemLabel.text = simpleItem.text
        
        itemLabel.layer.borderColor = UIColor.white.cgColor
        itemLabel.layer.borderWidth = 1.0
        itemLabel.layer.cornerRadius = 5.0
        
    }
    
}
