
//
//  PersonListPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 08/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: PersonListPresenter

class PersonListPresenter {
    
    var view: PersonListViewInterface?
    var interactor: PersonListInteractorInputInterface?
    var wireframe: PersonListWireframeInterface?
    
    var page: Int = 1
    var totalPage: Int = 1
    
    var persons: [Person]?
    
    var parameters: [String : String]?
    var url: String?
    
    init(view: PersonListViewInterface?) {
        self.view = view
    }
    
}

// MARK: HomePresenterInterface - Lifecycle methods

extension PersonListPresenter: PersonListPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
        
        if persons == nil {
            self.fetchPersons()
        }
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

// MARK: PersonListPresenterInterface - Fetch methods

extension PersonListPresenter {
    
    func fetchPersons() {
        if page > totalPage { return }
        
        guard let url = url else {
            self.view?.onError(message: "Houve um erro ao buscar os atores ou atrizes.")
            return
        }
        guard let baseParameters = parameters else {
            self.view?.onError(message: "Houve um erro ao buscar os atores ou atrizes.")
            return
        }
        
        let parameters = baseParameters.merge(with: [
            TMDB.Parameters.page: String(page)
            ])
        
        self.view?.showActivityIndicator()
        
        interactor?.fetchPersons(from: url, with: parameters)
    }
    
}

// MARK: PersonListPresenterInterface - User click methods

extension PersonListPresenter {
    
    func didSelectPerson(_ person: Person) {
        wireframe?.presentDetails(for: person)
    }
    
}

extension PersonListPresenter: PersonListInteractorOutputInterface {
    
    func personsDidFetch(_ persons: [Person], totalPages: Int) {
        self.totalPage = totalPages
        self.page += 1
        
        if self.persons != nil {
            self.persons! += persons
        } else {
            self.persons = persons
        }
        
        self.view?.hideActivityIndicator()
        self.view?.showPersons(with: self.persons!)
    }
    
    func personsDidError(_ error: DefaultError) {
        self.view?.onError(message: error.message)
    }
}
