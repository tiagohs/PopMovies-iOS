
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
    
    func didRegisterClicked(_ name: String?, _ email: String?, _ password: String?, _ confirmPassword: String?) {
        guard let name = name,
            let email = email,
            let password = password,
            let confirmPassword = confirmPassword else {
                self.view?.onError(message: "É necessário que todos os campos estejam preenxidos.")
                return
        }
        
        if password != confirmPassword {
            self.view?.onError(message: "Senha e confirmar senha devem ser iguais.")
            return
        }
        
        if !email.isValidEmail() {
            self.view?.onError(message: "Entre com um email valido.")
            return
        }
        
        self.view?.showActivityIndicator()
        self.interactor?.didRegisterClicked(name, email, password)
    }
    
}

// MARK: RegisterInteractorOutputInterface

extension RegisterPresenter: RegisterInteractorOutputInterface {
    
    func registerDidFinished() {
        self.view?.hideActivityIndicator()
        self.wireframe?.presentRootScreen()
    }
    
    func registerDidFinished(with error: DefaultError) {
        self.view?.hideActivityIndicator()
        self.view?.onError(message: error.message)
    }
}
