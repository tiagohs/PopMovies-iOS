
//
//  WelcomeWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: WelcomeWireframe: WelcomeWireframeInterface

class WelcomeWireframe: WelcomeWireframeInterface {
    
    weak var viewController: UIViewController?
    
}

// MARK: build's Module

extension WelcomeWireframe {
    
    static func buildModule() -> UIViewController {
        let wireframe = WelcomeWireframe()
        let view = R.storyboard.welcome.welcomeController()
        let presenter = WelcomePresenter(view: view)
        let interactor = WelcomeInteractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }

}
