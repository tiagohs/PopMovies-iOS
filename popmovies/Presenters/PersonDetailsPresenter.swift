//
//  PersonDetailsPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import RxSwift

class PersonDetailsPresenter: BasePresenter, IPersonDetailsPresenter {
    
    var view: IPersonDetailsView!
    var interactor: IPersonDetailsInteractor!
    
    init(view: IPersonDetailsView) {
        self.view = view
        self.interactor = PersonDetailsInteractor()
    }
    
    func fetchPersonDetails(personId: Int?) {
        guard let personId = personId else {
            
            return
        }
        
        add(interactor.fetchPersonDetails(personId: personId)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (person) in
                self.view.bindPerson(person: person)
            }, onError: { (error) in
                //
            })
        )
    }
    
}
