
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
    
    init(view: PersonListViewInterface?) {
        self.view = view
    }
    
}

// MARK: HomePresenterInterface - Lifecycle methods

extension PersonListPresenter: PersonListPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

extension PersonListPresenter: PersonListInteractorOutputInterface {
    
}
