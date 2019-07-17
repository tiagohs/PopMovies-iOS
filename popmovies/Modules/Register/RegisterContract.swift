
//
//  RegisterContract.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

protocol RegisterViewInterface: BaseViewInterface {
    var presenter: RegisterPresenterInterface? { get set }
    
}

protocol RegisterPresenterInterface: BasePresenterInterface {
    
    var view: RegisterViewInterface? { get set }
    var interactor: RegisterInteractorInputInterface? { get set }
    var wireframe: RegisterWireframeInterface? { get set }
    
    func didRegisterClicked(_ name: String?, _ email: String?, _ password: String?, _ confirmPassword: String?)
}

protocol RegisterInteractorInputInterface: BaseInteractorInterface {
    var output: RegisterInteractorOutputInterface? { get set }
    
    func didRegisterClicked(_ name: String, _ email: String, _ password: String)
}

protocol RegisterInteractorOutputInterface {
    
    func registerDidFinished()
    func registerDidFinished(with error: DefaultError)
}

protocol RegisterWireframeInterface: BaseWireframeInterface {
    
    func presentRootScreen()
    
    static func buildModule() -> UIViewController
}
