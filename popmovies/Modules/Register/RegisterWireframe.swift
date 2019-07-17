
//
//  RegisterWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: RegisterWireframe: RegisterWireframeInterface

class RegisterWireframe: RegisterWireframeInterface {
    
    weak var viewController: UIViewController?
    
    func presentRootScreen() {
        let module = RootWireframe.buildModule()
        
        self.viewController?.hero.replaceViewController(with: module)
    }
    
}

// MARK: build's Module

extension RegisterWireframe {
    
    static func buildModule() -> UIViewController {
        let wireframe = RegisterWireframe()
        let view = R.storyboard.register.registerController()
        let presenter = RegisterPresenter(view: view)
        let interactor = RegisterInteractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }

}
