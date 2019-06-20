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


protocol IPersonService {
    
    func getDetails(personId: Int, appendToResponse: [String], language: String) -> Observable<Person>
    
}

class PersonService: BaseService, IPersonService {
    var serviceUrl: String = ""
    
    override init() {
        super.init()
        
        serviceUrl = "\(baseUrl)person"
    }
    
    func getDetails(personId: Int, appendToResponse: [String], language: String) -> Observable<Person> {
        let appendToResponse = createAppendToResponse(appendToResponse: appendToResponse)
        let parameters = [
            Constants.TMDB.Parameters.apiKey: Constants.TMDB.API_KEY,
            Constants.TMDB.Parameters.language: language,
            "append_to_response": appendToResponse
        ]
        let url = "\(serviceUrl)/\(personId)"
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: Person.self)
    }
}
