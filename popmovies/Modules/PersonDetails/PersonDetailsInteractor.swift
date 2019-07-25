//
//  PersonDetailsInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 19/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: PersonDetailsInteractor: BaseInteractor

class PersonDetailsInteractor: BaseInteractor {
    let personService: PersonServiceInterface
    
    var output: PersonDetailsInteractorOutputInterface?
    
    init(output: PersonDetailsInteractorOutputInterface?) {
        self.output = output
        self.personService = PersonService()
    }
    
}

// MARK: HomeInteractorInputInterface - Output lifecycle Methods

extension PersonDetailsInteractor: PersonDetailsInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {}
}

// MARK: HomeInteractorInputInterface - Fetch methods

extension PersonDetailsInteractor {
    
    func fetchPersonDetails(_ personId: Int) {
        let appendToResponse = [
            TMDB.Parameters.tagged_images,
            TMDB.Parameters.images,
            TMDB.Parameters.movie_credits,
            TMDB.Parameters.external_ids]
        
        add(personService.getDetails(personId: personId, appendToResponse: appendToResponse, language: "en,pt_BR,null")
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (person) in
                self.output?.personDetailsDidFetch(person)
            }, onError: { (error) in
                self.output?.personDetailsDidError(DefaultError(message: R.string.localizable.personsDetailsNotFound()))
            })
        )
    }
}
