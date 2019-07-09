
//
//  RegisterPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: RegisterPresenter

class RegisterPresenter {
    
    var view: RegisterViewInterface?
    var interactor: RegisterInteractorInputInterface?
    var wireframe: RegisterWireframeInterface?
    
    init(view: RegisterViewInterface?) {
        self.view = view
    }
    
}

// MARK: RegisterPresenterInterface - Lifecycle methods

extension RegisterPresenter: RegisterPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

// MARK: RegisterPresenterInterface - User click methods

extension RegisterPresenter {
    
    func didRegisterClicked() {
        
    }
    
}

// MARK: RegisterInteractorOutputInterface

extension RegisterPresenter: RegisterInteractorOutputInterface {
    
}
