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
    
    var isProfileImageBind = false
    var isBackdropImageBind = false
    
    var allImages: [Image] = []
    var allMovies: [Movie] = []
    
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
        
        facebookButton.isEnabled = person.externalIds?.facebookId != nil
        twitterButton.isEnabled = person.externalIds?.twitterId != nil
        instagramButton.isEnabled = person.externalIds?.instagramId != nil
    }
    
    private func bindContent(_ person: Person) {
        nameLabel.text = person.name
        
        bindCounts(person)
    }
    
    private func bindCounts(_ person: Person) {
        allMovies = mergeMovies()
        allImages = mergeImages()
        
        totalMoviesLabel.text = String(describing: allMovies.count)
        totalPicturesLabel.text = String(describing: allImages.count)
    }
    
    private func mergeImages() -> [Image] {
        guard let person = self.person else { return [] }
        let taggedImages = person.taggedImages?.results?.map({ (taggedImagesResults) -> Image in
            let image = Image()
            image.filePath = taggedImagesResults.filePath
            
            return image
        }) ?? []
        let profileImages = person.images?.profile ?? []
        
        return taggedImages + profileImages
    }
    
    private func mergeMovies() -> [Movie] {
        let castCredits = person?.movieCredits?.cast?.map({ (creditCast) -> Movie in
            let movie = Movie()
            
            movie.id = creditCast.id
            movie.title = creditCast.title
            movie.posterPath = creditCast.posterPath
            movie.backdropPath = creditCast.backdropPath
            movie.releaseDate = creditCast.releaseDate
            
            return movie
        }) ?? []
        let crewCredits = person?.movieCredits?.crew?.map({ (creditCrew) -> Movie in
            let movie = Movie()
            
            movie.id = creditCrew.id
            movie.title = creditCrew.title
            movie.posterPath = creditCrew.posterPath
            movie.backdropPath = creditCrew.backdropPath
            movie.releaseDate = creditCrew.releaseDate
            
            return movie
        }) ?? []
        
        return castCredits + crewCredits
    }
    
    @IBAction func didFacebookClicked() {
        guard let url = URLUtils.formatFacebookUrl(facebookId: person?.externalIds?.facebookId) else { return }
        
        openLink(link: url)
    }
    
    @IBAction func didTwitterClicked() {
        guard let url = URLUtils.formatTwitterUrl(twitterId: person?.externalIds?.twitterId) else { return }
        
        openLink(link: url)
    }
    
    @IBAction func didInstagramClicked() {
        guard let url = URLUtils.formatInstagramUrl(instagramId: person?.externalIds?.instagramId) else { return }
        
        openLink(link: url)
    }
    
    private func openLink(link: String) {
        if let encoded = link.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let myURL = URL(string: encoded) {
            UIApplication.shared.open(myURL)
        }
    }
}
