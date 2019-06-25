//
//  SimpleItemCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class SimpleItemCell: UICollectionViewCell {

    @IBOutlet weak var buttonView: UIButton!
    var simpleItem: SimpleItem? = nil
    
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
    
    func bindSimpleItem(simpleItem: SimpleItem) {
        self.simpleItem = simpleItem
        
        buttonView.setTitle("\(String(simpleItem.text))", for: .normal)
        buttonView.setTitleColor(UIColor.white, for: .normal)
        buttonView.sizeToFit()
        buttonView.contentEdgeInsets = UIEdgeInsets(top: 5,left: 10,bottom: 5,right: 10)
        buttonView.layer.borderColor = UIColor.white.cgColor
        buttonView.layer.borderWidth = 1.0
        buttonView.layer.cornerRadius = 5.0
    }

}
