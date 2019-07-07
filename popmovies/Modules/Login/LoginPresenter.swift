
//
//  LoginPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: LoginPresenter

class LoginPresenter {
    
    var view: LoginViewInterface?
    var interactor: LoginInteractorInputInterface?
    var wireframe: LoginWireframeInterface?
    
    init(view: LoginViewInterface?) {
        self.view = view
    }
    
}

// MARK: HomePresenterInterface - Lifecycle methods

extension LoginPresenter: LoginPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

extension LoginPresenter: LoginInteractorOutputInterface {
    
}
