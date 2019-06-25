//
//  PersonService.swift
//  popmovies
//
//  Created by Tiago Silva on 19/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

// MARK: IPersonService

protocol IPersonService {
    
    func getDetails(personId: Int, appendToResponse: [String], language: String) -> Observable<Person>
}

// MARK: PersonService: IPersonService

class PersonService: IPersonService {
    
    func getDetails(personId: Int, appendToResponse: [String], language: String) -> Observable<Person> {
        let url = TMDB.URL.PERSON.buidPersonDetailsUrl(personId: personId)
        let parameters = TMDB.URL.PERSON.buildPersonDetailsParameters(appendToResponse, language)
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: Person.self)
    }
}
