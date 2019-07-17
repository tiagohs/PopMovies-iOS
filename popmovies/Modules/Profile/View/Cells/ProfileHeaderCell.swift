//
//  ProfileHeaderCell.swift
//  popmovies
//
//  Created by Tiago Silva on 07/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    
    @IBOutlet weak var totalMoviesLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var monthsLabel: UILabel!
    
    var user: UserLocal? {
        didSet { bindUI(user!) }
    }
    
    //MARK: init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
    }
    
    func setupUI() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        
        facebookButton.layer.cornerRadius = facebookButton.bounds.width / 2
        instagramButton.layer.cornerRadius = instagramButton.bounds.width / 2
        twitterButton.layer.cornerRadius = twitterButton.bounds.width / 2
    }
    
    func bindUI(_ user: UserLocal) {
        nameLabel.text = user.name
        emailLabel.text = user.email
        totalMoviesLabel.text = String(format: user.totalMovies < 10 ? "%02d" : "%d", user.totalMovies)
        
        if let profileImage = user.photoURL {
            profileImageView.setImage(imageUrl: profileImage.absoluteString, contentMode: .scaleAspectFill, placeholderImageName: Constants.IMAGES.PLACEHOLDER_POSTER_PROFILE)
        }
        let (months, days, hours) = user.totalDuration
        
        hoursLabel.text = String(format: hours < 10 ? "%02d" : "%d", hours)
        daysLabel.text = String(format: days < 10 ? "%02d" : "%d", days)
        monthsLabel.text = String(format: months < 10 ? "%02d" : "%d", months)
    }
}
