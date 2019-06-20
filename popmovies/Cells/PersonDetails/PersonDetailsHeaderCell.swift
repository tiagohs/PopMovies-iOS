//
//  PersonHeaderCell.swift
//  popmovies
//
//  Created by Tiago Silva on 19/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

class PersonDetailsHeaderCell: UITableViewCell {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalMoviesLabel: UILabel!
    @IBOutlet weak var totalPicturesLabel: UILabel!
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!

    var person: Person? {
        didSet { bindPerson(self.person!) }
    }
    
    private func bindPerson(_ person: Person) {
        bindProfileImage(person)
        bindBackdropImage(person)
        bindSocialLinks(person)
        bindContent(person)
    }
    
    private func bindProfileImage(_ person: Person) {
        guard let profilePath = person.profilePath else {
            return
        }
        
        profileImageView.setTMDBImageBy(url: profilePath, contentSize: Constants.TMDB.ImageSize.POSTER.w500, placeholder: Constants.IMAGES.PLACEHOLDER_POSTER_PROFILE)
        profileImageView.hero.id = String(describing: person.id)
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
    }
    
    private func bindBackdropImage(_ person: Person) {
        var backdropPath: String? = nil
        
        if let taggedImages = person.taggedImages?.results, taggedImages.count > 0 {
            backdropPath = taggedImages[0].filePath
        } else if let profileImages = person.images?.profile, profileImages.count > 0 {
            backdropPath = profileImages[0].filePath
        }
        
        backdropImageView.setTMDBImageBy(url: backdropPath, contentSize: Constants.TMDB.ImageSize.BACKDROP.w780, placeholder: Constants.IMAGES.PLACEHOLDER_BACKDROP_MOVIE)
    }
    
    private func bindSocialLinks(_ person: Person) {
        facebookButton.layer.cornerRadius = facebookButton.bounds.width / 2
        twitterButton.layer.cornerRadius = twitterButton.bounds.width / 2
        instagramButton.layer.cornerRadius = instagramButton.bounds.width / 2
        
        facebookButton.isEnabled = person.externalIds?.facebookId != nil
        twitterButton.isEnabled = person.externalIds?.twitterId != nil
        instagramButton.isEnabled = person.externalIds?.instagramId != nil
    }
    
    private func bindContent(_ person: Person) {
        nameLabel.text = person.name
        
        bindCounts(person)
    }
    
    private func bindCounts(_ person: Person) {
        let castCredits = person.movieCredits?.cast ?? []
        let crewCredits = person.movieCredits?.crew ?? []
        let profileImages = person.images?.profile ?? []
        let taggedImages = person.taggedImages?.results?.map({ (taggedImagesResults) -> Image in
            let image = Image()
            image.filePath = taggedImagesResults.filePath
            
            return image
        }) ?? []
        
        let totalCredits = castCredits + crewCredits
        let totalPictures = profileImages + taggedImages
        
        totalMoviesLabel.text = String(describing: totalCredits.count)
        totalPicturesLabel.text = String(describing: totalPictures.count)
    }
}
