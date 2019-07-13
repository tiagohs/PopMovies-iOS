//
//  ProfileContract.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit


protocol ProfileViewInterface: BaseViewInterface {
    var presenter: ProfilePresenterInterface? { get set }
    
    func setupProfileUI(with user: UserLocal)
}

protocol ProfilePresenterInterface: BasePresenterInterface {
    
    var view: ProfileViewInterface? { get set }
    var interactor: ProfileInteractorInputInterface? { get set }
    var wireframe: ProfileWireframeInterface? { get set }
    
    func didSingUpClicked()
}

protocol ProfileInteractorInputInterface: BaseInteractorInterface {
    var output: ProfileInteractorOutputInterface? { get set }
    
    func didSingUpClicked()
}

protocol ProfileInteractorOutputInterface {
    
    func didSignOutFinished()
    func didSignOutError(_ error: DefaultError)
}

protocol ProfileWireframeInterface: BaseWireframeInterface {
    
    func presentWelcomeScreen()
    
    static func buildModule() -> UIViewController
}
