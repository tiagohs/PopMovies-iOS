//
//  PersonDetailsContract.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import RxSwift

protocol IPersonDetailsView: IBaseView {
    
    func bindPerson(person: Person)
}

protocol IPersonDetailsPresenter: IBasePresenter {
    
    func fetchPersonDetails(personId: Int?)
}

protocol IPersonDetailsInteractor {
    
    func fetchPersonDetails(personId: Int) -> Observable<Person>
}

