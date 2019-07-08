
//
//  SearchPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 08/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: SearchPresenter

class SearchPresenter {
    
    var view: SearchViewInterface?
    var interactor: SearchInteractorInputInterface?
    var wireframe: SearchWireframeInterface?
    
    init(view: SearchViewInterface?) {
        self.view = view
    }
    
}

// MARK: HomePresenterInterface - Lifecycle methods

extension SearchPresenter: SearchPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
        self.view?.setupSearchController()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

extension SearchPresenter: SearchInteractorOutputInterface {
    
}
