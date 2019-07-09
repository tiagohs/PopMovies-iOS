//
//  RootContract.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit


protocol RootViewInterface {
    var presenter: RootPresenterInterface? { get set }
    
    func setupUI()
}

protocol RootPresenterInterface: BasePresenterInterface {
    
    var view: RootViewInterface? { get set }
    var interactor: RootInteractorInputInterface? { get set }
    var wireframe: RootWireframeInterface? { get set }
    
}

protocol RootInteractorInputInterface: BaseInteractorInterface {
    var output: RootInteractorOutputInterface? { get set }
    
}

protocol RootInteractorOutputInterface {
    
}

protocol RootWireframeInterface: BaseWireframeInterface {
    
    static func buildModule() -> UIViewController
}
