
//
//  LoginWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: LoginWireframe: LoginWireframeInterface

class LoginWireframe: LoginWireframeInterface {
    
    weak var viewController: UIViewController?
    
}

// MARK: build's Module

extension LoginWireframe {
    
    static func buildModule() -> UIViewController {
        let wireframe = LoginWireframe()
        let view = R.storyboard.login.loginController()
        let presenter = LoginPresenter(view: view)
        let interactor = LoginInteractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }

}
