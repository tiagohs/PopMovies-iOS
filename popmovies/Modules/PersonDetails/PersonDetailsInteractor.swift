//
//  PersonDetailsInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 19/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

class PersonDetailsInteractor: IPersonDetailsInteractor { 
    
    var personService: IPersonService
    
    init() {
        personService = PersonService()
    }
    
    func fetchPersonDetails(personId: Int) -> Observable<Person> {
        let appendToResponse = ["tagged_images", "images", "movie_credits", "external_ids"]
        
        return personService.getDetails(personId: personId, appendToResponse: appendToResponse, language: "en,pt_BR,null")
    }
}
