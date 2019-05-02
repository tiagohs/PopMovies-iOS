//
//  VideoCell.swift
//  popmovies
//
//  Created by Tiago Silva on 21/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoTitleView: UILabel!
    @IBOutlet weak var videoSubtitleView: UILabel!
    
    var video: Video? {
        didSet {
            bindVideo(video: self.video!)
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
    
    private func bindVideo(video: Video) {
        
        videoTitleView.text = video.name
        if let videoUrl = URLUtils.formatYoutubeUrl(videoId: video.key) {
            videoImageView.setImage( imageUrl: videoUrl, contentMode: .scaleAspectFill, placeholderImageName: "BackdropPlaceholder")
        } else {
            videoImageView.image = UIImage(named: "BackdropPlaceholder")
        }
        
        videoImageView.layer.cornerRadius = 5
        
        var videoSubtitle = ""
        
        if let language = video.language, let videoLanguage = Locale(identifier: "pt_BR").localizedString(forIdentifier: language) {
            videoSubtitle += videoLanguage
        }
        
        if let type = video.type {
            videoSubtitle += " | \(type)"
        }
        
        videoSubtitleView.text = videoSubtitle
    }
}
