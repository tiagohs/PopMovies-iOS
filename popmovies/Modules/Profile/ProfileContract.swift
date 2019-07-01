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
    
}

protocol ProfilePresenterInterface: BasePresenterInterface {
    
    var view: ProfileViewInterface? { get set }
    var interactor: ProfileInteractorInputInterface? { get set }
    var wireframe: ProfileWireframeInterface? { get set }
    
}

protocol ProfileInteractorInputInterface: BaseInteractorInterface {
    var output: ProfileInteractorOutputInterface? { get set }
    
}

protocol ProfileInteractorOutputInterface {
    
}

protocol ProfileWireframeInterface: BaseWireframeInterface {
    
    static func buildModule() -> UIViewController
}
