//
//  RootPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class RootWireframe: RootWireframeInterface {
    
    weak var viewController: UIViewController?
}

extension RootWireframe {
    
    static func buildModule(with submodules: Submodules) -> UIViewController {
        let wireframe = RootWireframe()
        let tabs = RootTabBarWireframe.buildTabs(with: submodules)
        let view = RootController(tabs: tabs)
        let presenter = RootPresenter(view: view)
        let interactor = RootInteractor(output: presenter)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view
    }
}
