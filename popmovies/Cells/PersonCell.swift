//
//  PersonCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
    
    @IBOutlet weak var personPictureView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var subtitleView: UILabel!
    
    var person: PersonItem? {
        didSet { bindPersonCellContent(person: person!) }
    }
    
    private func bindPersonCellContent(person: PersonItem) {
        
        if let pictureUrl = ImageUtils.formatImageUrl(imageID: person.pictureId, imageSize: Constants.TMDB.ImageSize.PROFILE.w185) {
            
            personPictureView.setImage( imageUrl: pictureUrl, contentMode: .scaleAspectFill, placeholderImageName: "ProfilePlaceholder")
        } else {
            personPictureView.image = UIImage(named: "ProfilePlaceholder")
        }
        
        personPictureView.layer.cornerRadius = personPictureView.bounds.width / 2
        personPictureView.layer.masksToBounds = true
        
        nameView.text = person.name
        subtitleView.text = person.subtitle
        subtitleView.sizeToFit()
    }
}
