
//
//  SearchContract.swift
//  popmovies
//
//  Created by Tiago Silva on 08/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

protocol SearchViewInterface: BaseViewInterface {
    var presenter: SearchPresenterInterface? { get set }
    
    func setupSearchController() 
}

protocol SearchPresenterInterface: BasePresenterInterface {
    
    var view: SearchViewInterface? { get set }
    var interactor: SearchInteractorInputInterface? { get set }
    var wireframe: SearchWireframeInterface? { get set }
    
}

protocol SearchInteractorInputInterface: BaseInteractorInterface {
    var output: SearchInteractorOutputInterface? { get set }
    
}

protocol SearchInteractorOutputInterface {
    
}

protocol SearchWireframeInterface: BaseWireframeInterface {
    
    static func buildModule() -> UIViewController
}
