//
//  RootPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: ProfilePresenter

class RootPresenter {
    
    var view: RootViewInterface?
    var interactor: RootInteractorInputInterface?
    var wireframe: RootWireframeInterface?
    
    init(view: RootViewInterface?) {
        self.view = view
    }
    
}

// MARK: RootPresenterInterface

extension RootPresenter: RootPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

// MARK: RootInteractorOutputInterface

extension RootPresenter: RootInteractorOutputInterface {
    
}
