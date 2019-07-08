//
//  PersonHeaderCell.swift
//  popmovies
//
//  Created by Tiago Silva on 19/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

// MARK: PersonDetailsHeaderCell: UITableViewCell

class PersonDetailsHeaderCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalMoviesLabel: UILabel!
    @IBOutlet weak var totalPicturesLabel: UILabel!
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    
    // MARK: Properties
    
    var delegate: PersonDetailsHeaderDelegate?
    var person: Person? {
        didSet { bindPerson(self.person!) }
    }
    
    var isProfileImageBind = false
    var isBackdropImageBind = false
    
    var allImages: [Image] = []
    var allMovies: [Movie] = []
}

// MARK: Bind methods

extension PersonDetailsHeaderCell {
    
    func bindBackdropImage(_ person: Person) {
        
        if (!isBackdropImageBind) {
            var backdropPath: String? = nil
            
            if let taggedImages = person.taggedImages?.results, taggedImages.count > 0 {
                backdropPath = taggedImages[0].filePath
            } else if let profileImages = person.images?.profile, profileImages.count > 0 {
                backdropPath = profileImages[0].filePath
            } else {
                backdropPath = person.profilePath
            }
            
            backdropImageView.setTMDBImageBy(url: backdropPath, contentSize: TMDB.ImageSize.BACKDROP.w780, contentMode: .scaleAspectFill, placeholder: nil)
            
            isBackdropImageBind = true
        }
    }
    
    private func bindPerson(_ person: Person) {
        bindProfileImage(person)
        bindSocialLinks(person)
        bindContent(person)
    }
    
    private func bindProfileImage(_ person: Person) {
        
        if (!isProfileImageBind) {
            guard let profilePath = person.profilePath else {
                return
            }
            
            profileImageView.setTMDBImageBy(url: profilePath, contentSize: TMDB.ImageSize.POSTER.w500, contentMode: .scaleAspectFill, placeholder: nil)
            profileImageView.hero.id = String(describing: person.id)
            profileImageView.hero.modifiers = [.scale(0.6)]
            
            profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
            
            isProfileImageBind = true
        }
        
    }
    
    private func bindSocialLinks(_ person: Person) {
        facebookButton.layer.cornerRadius = facebookButton.bounds.width / 2
        twitterButton.layer.cornerRadius = twitterButton.bounds.width / 2
        instagramButton.layer.cornerRadius = instagramButton.bounds.width / 2
        
        if person.externalIds != nil {
            bindSocialButton(facebookButton, person.externalIds?.facebookId)
            bindSocialButton(twitterButton, person.externalIds?.twitterId)
            bindSocialButton(instagramButton, person.externalIds?.instagramId)
        }
    }
    
    private func bindSocialButton(_ button: UIButton, _ externalLinkKey: String?) {
        if externalLinkKey != nil { return }
        
        button.isEnabled = false
        button.backgroundColor = UIColor.darkGray
        button.alpha = 0.5
    }
    
    private func bindContent(_ person: Person) {
        nameLabel.text = person.name
        
        bindCounts(person)
    }
    
    private func bindCounts(_ person: Person) {
        allMovies = person.allMovieCredits
        allImages = person.allImages
        
        totalMoviesLabel.text = String(describing: allMovies.count)
        totalPicturesLabel.text = String(describing: allImages.count)
    }
    
}

// MARK: Actions methods

private extension PersonDetailsHeaderCell {
    
    @IBAction func didFacebookClicked() {
        delegate?.didFacebookClicked()
    }
    
    @IBAction func didTwitterClicked() {
        delegate?.didTwitterClicked()
    }
    
    @IBAction func didInstagramClicked() {
        delegate?.didInstagramClicked()
    }
}
