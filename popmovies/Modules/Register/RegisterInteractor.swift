
//
//  RegisterInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: RegisterInteractor: BaseInteractor

class RegisterInteractor: BaseInteractor {
    let authManager: AuthManager!
    
    var output: RegisterInteractorOutputInterface?
    
    init(output: RegisterInteractorOutputInterface?) {
        self.output = output
        self.authManager = AuthManager.shared
    }
}

// MARK: RegisterInteractorInputInterface - Output lifecycle Methods

extension RegisterInteractor: RegisterInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {
        disposibles.dispose()
        
        self.output = nil
    }
    
}

// MARK: RegisterInteractorInputInterface - Click methods

extension RegisterInteractor {
    
    func didRegisterClicked(_ name: String, _ email: String, _ password: String) {
        self.authManager.signUp(with: email, password, name) { (user, error) in
            if error != nil {
                self.output?.registerDidFinished(with: error!)
                return
            }
            
            self.output?.registerDidFinished()
        }
    }
    
}
