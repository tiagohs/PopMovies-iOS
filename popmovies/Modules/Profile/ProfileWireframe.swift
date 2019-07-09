//
//  ProfileWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class ProfileWireframe: ProfileWireframeInterface {
    
    weak var viewController: UIViewController?
    
    func presentWelcomeScreen() {
        let module = WelcomeWireframe.buildModule()
        
        self.viewController?.tabBarController?.hero.replaceViewController(with: module)
    }
}

extension ProfileWireframe {
    
    static func buildModule() -> UIViewController {
        let view = R.storyboard.profile.profileController()
        
        return build(view)
    }
    
    static func buildModuleFromUINavigation() -> UIViewController {
        let navigationController = R.storyboard.profile.profileNavigationController()
        let view = navigationController?.viewControllers.first as! ProfileController
        
        _ = build(view)
        
        return navigationController!
    }
    
    private static func build(_ view: ProfileController?) -> UIViewController  {
        let wireframe = ProfileWireframe()
        let presenter = ProfilePresenter(view: view)
        let interactor = ProfileInteractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }
}
