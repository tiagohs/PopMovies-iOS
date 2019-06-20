//
//  PersonDetailsOverviewCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class PersonDetailsOverviewCell: UITableViewCell {
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var knownForLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    
    @IBOutlet weak var imdbButton: UIButton!
    @IBOutlet weak var wikiButton: UIButton!

    var isExternalLinksViewBinded = false
    var person: Person? {
        didSet { bindPerson(self.person!) }
    }
    
    let shadowpath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width:
        35, height: 35), byRoundingCorners:
        [.topRight, .bottomRight], cornerRadii: CGSize(width: 28.0, height: 0.0))
    let shadowOffset = CGSize(width: 0.8, height: 0.4)
    
    private func bindPerson(_ person: Person) {
        biographyLabel.text = person.biography
        
        genreLabel.text = getGender(person.gender)
        placeOfBirthLabel.text = person.placeOfBirth
        birthdayLabel.text = person.birthday?.formatDate(pattner: "MMM d, yyyy")
        knownForLabel.text = person.knownForDepartment
        
        if !isExternalLinksViewBinded {
            self.setupExternalLinkView(imdbButton)
            self.setupExternalLinkView(wikiButton)
            
            isExternalLinksViewBinded = true
        }
    }
    
    private func getGender(_ genderId: Int?) -> String? {
        
        switch genderId {
        case 1:
            return "Female"
        case 2:
            return "Male"
        default:
            return "Unknown"
        }
    }
    
    private func setupExternalLinkView(_ buttonView: UIButton) {
        buttonView.layer.cornerRadius = buttonView.bounds.width / 2
        buttonView.layer.shadowColor = UIColor.black.cgColor
        buttonView.layer.shadowOffset = shadowOffset
        buttonView.layer.shadowOpacity = 0.5
        buttonView.layer.shadowRadius = buttonView.bounds.width / 2
        buttonView.layer.masksToBounds =  false
        buttonView.layer.shadowPath = shadowpath.cgPath
    }
    
    @IBAction func didImdbLinkTaped() {
        guard let imdbURL = URLUtils.formartPersonIMDB(imdbId: person?.imdbId) else { return }
        
        openLink(link: imdbURL)
    }
    
    @IBAction func didWikiLinkTaped() {
        guard let wikiUrl = URLUtils.formatWikiUrl(wikiSearchTerm: person?.name) else { return }
        
        openLink(link: wikiUrl)
    }
    
    private func openLink(link: String) {
        if let encoded = link.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let myURL = URL(string: encoded) {
            UIApplication.shared.open(myURL)
        }
    }
}
