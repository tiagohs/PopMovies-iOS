
//
//  LoginContract.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewInterface: BaseViewInterface {
    var presenter: LoginPresenterInterface? { get set }
    
    func setupGoogleAuthUI()
}

protocol LoginPresenterInterface: BasePresenterInterface {
    
    var view: LoginViewInterface? { get set }
    var interactor: LoginInteractorInputInterface? { get set }
    var wireframe: LoginWireframeInterface? { get set }
    
    func didSignUpClicked()
    func didSignWithEmailClicked(_ email: String, _ password: String)
    func didSignWithFaceIdClicked()
    func didSignWithFacebookClicked(with viewController: UIViewController)
    func didSignWithTwitterClicked(with viewController: UIViewController)
    func didSignWithGoogleClicked()
}

protocol LoginInteractorInputInterface: BaseInteractorInterface {
    var output: LoginInteractorOutputInterface? { get set }
    
    func didSignWithGoogle()
    func didSignWithFacebook(with viewController: UIViewController)
    func didSignWithTwitter(with viewController: UIViewController)
    func didSignWithEmail(_ email: String, _ password: String)
    func didSignWithFaceID()
}

protocol LoginInteractorOutputInterface {
    
    func didLoginSuccess(user: UserLocal)
    func didLoginError(error: DefaultError)
}

protocol LoginWireframeInterface: BaseWireframeInterface {
    
    func presentSignUp()
    func presentRootScreen()
    
    static func buildModule() -> UIViewController
}
