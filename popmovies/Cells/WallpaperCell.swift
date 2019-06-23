//
//  WallpaperCell.swift
//  popmovies
//
//  Created by Tiago Silva on 21/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class WallpaperCell: UICollectionViewCell {
    
    @IBOutlet weak var wallpaperImageView: UIImageView!

    var image: Image? {
        didSet {
            bindWallpaper(wallpaper: image!)
        }
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
    
    private func bindWallpaper(wallpaper: Image) {
        if let backdropUrl = ImageUtils.formatImageUrl(imageID: wallpaper.filePath, imageSize: Constants.TMDB.ImageSize.BACKDROP.w780) {
            
            wallpaperImageView.setImage( imageUrl: backdropUrl, contentMode: .scaleAspectFill, placeholderImageName: "BackdropPlaceholder")
            wallpaperImageView.hero.id = String(describing: wallpaper.filePath)
        } else {
            wallpaperImageView.image = UIImage(named: "BackdropPlaceholder")
        }
    }
}
