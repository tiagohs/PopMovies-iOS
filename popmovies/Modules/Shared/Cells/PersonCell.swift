//
//  PersonCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

class PersonCell: UICollectionViewCell {
    
    @IBOutlet weak var personPictureView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var subtitleView: UILabel!
    
    var person: PersonItem? {
        didSet { bindPersonCellContent(person: person!) }
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
    
    private func bindPersonCellContent(person: PersonItem) {
        
        personPictureView.setTMDBImageBy(url: person.pictureId, contentSize: TMDB.ImageSize.PROFILE.w185, contentMode: .scaleAspectFill, placeholder: R.image.profilePlaceholder.name)
        
        personPictureView.layer.cornerRadius = personPictureView.bounds.width / 2
        personPictureView.layer.masksToBounds = true
        personPictureView.hero.id = String(describing: person.id)
        
        nameView.text = person.name
        subtitleView.text = person.subtitle
        subtitleView.sizeToFit()
    }
}
