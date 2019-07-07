
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
    
}

protocol LoginPresenterInterface: BasePresenterInterface {
    
    var view: LoginViewInterface? { get set }
    var interactor: LoginInteractorInputInterface? { get set }
    var wireframe: LoginWireframeInterface? { get set }
    
}

protocol LoginInteractorInputInterface: BaseInteractorInterface {
    var output: LoginInteractorOutputInterface? { get set }
    
}

protocol LoginInteractorOutputInterface {
    
}

protocol LoginWireframeInterface: BaseWireframeInterface {
    
    static func buildModule() -> UIViewController
}
