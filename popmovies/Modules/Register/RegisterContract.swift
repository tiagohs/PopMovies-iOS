
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
    
    func didRegisterClicked()
}

protocol RegisterInteractorInputInterface: BaseInteractorInterface {
    var output: RegisterInteractorOutputInterface? { get set }
    
}

protocol RegisterInteractorOutputInterface {
    
}

protocol RegisterWireframeInterface: BaseWireframeInterface {
    
    static func buildModule() -> UIViewController
}
