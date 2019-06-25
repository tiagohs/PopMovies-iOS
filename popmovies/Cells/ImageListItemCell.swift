//
//  ImageListItemCell.swift
//  popmovies
//
//  Created by Tiago Silva on 21/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

class ImageListItemCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: Image? {
        didSet { bindImage(self.image!) }
    }
    
    private func bindImage(_ image: Image) {
        imageView.setTMDBImageBy(url: image.filePath, contentSize: Constants.TMDB.ImageSize.BACKDROP.w780, contentMode: .scaleAspectFill, placeholder: nil)
        
        imageView.hero.id = image.filePath
        imageView.hero.modifiers = [.fade, .scale(0.8)]
        imageView.isOpaque = true
    }
}
