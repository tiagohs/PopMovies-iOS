
//
//  WelcomeContract.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

protocol WelcomeViewInterface: BaseViewInterface {
    var presenter: WelcomePresenterInterface? { get set }
    
}

protocol WelcomePresenterInterface: BasePresenterInterface {
    
    var view: WelcomeViewInterface? { get set }
    var interactor: WelcomeInteractorInputInterface? { get set }
    var wireframe: WelcomeWireframeInterface? { get set }
    
    func didLoginClicked()
    func didRegisterClicked()
}

protocol WelcomeInteractorInputInterface: BaseInteractorInterface {
    var output: WelcomeInteractorOutputInterface? { get set }
    
}

protocol WelcomeInteractorOutputInterface {
    
}

protocol WelcomeWireframeInterface: BaseWireframeInterface {
    
    func presentLogin()
    func presentRegister()
    
    static func buildModule() -> UIViewController
}
