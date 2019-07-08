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
}
