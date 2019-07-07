
//
//  WelcomePresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: WelcomePresenter

class WelcomePresenter {
    
    var view: WelcomeViewInterface?
    var interactor: WelcomeInteractorInputInterface?
    var wireframe: WelcomeWireframeInterface?
    
    init(view: WelcomeViewInterface?) {
        self.view = view
    }
    
}

// MARK: HomePresenterInterface - Lifecycle methods

extension WelcomePresenter: WelcomePresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

extension WelcomePresenter: WelcomeInteractorOutputInterface {
    
}
