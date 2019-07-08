
//
//  PersonListInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 08/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: PersonListInteractor: BaseInteractor

class PersonListInteractor: BaseInteractor {
    let service: PersonServiceInterface!
    
    var output: PersonListInteractorOutputInterface?
    
    init(output: PersonListInteractorOutputInterface?) {
        self.output = output
        self.service = PersonService()
    }
}

// MARK: PersonListInteractorInputInterface - Output lifecycle Methods

extension PersonListInteractor: PersonListInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
    
}

// MARK: PersonListInteractorInputInterface - Fetch methods

extension PersonListInteractor {
    
    func fetchPersons(from url: String,with parameters: [String : String ]) {
        add(service.getPersonList(url: url, paramenters: parameters)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (personsResult) in
                guard let persons = personsResult.results else {
                    self.onError()
                    return
                }
                guard let totalPages = personsResult.total_pages else {
                    self.onError()
                    return
                }
                
                self.output?.personsDidFetch(persons, totalPages: totalPages)
            }, onError: { (error) in
                self.onError()
            })
        )
    }
    
    private func onError(message: String = "Houve um erro ou não encontramos nenhum pessoa .") {
        self.output?.personsDidError(DefaultError(message: message))
    }
    
}
