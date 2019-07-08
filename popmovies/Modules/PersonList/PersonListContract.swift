
//
//  PersonListContract.swift
//  popmovies
//
//  Created by Tiago Silva on 08/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

protocol PersonListViewInterface: BaseViewInterface {
    var presenter: PersonListPresenterInterface? { get set }
    
}

protocol PersonListPresenterInterface: BasePresenterInterface {
    
    var view: PersonListViewInterface? { get set }
    var interactor: PersonListInteractorInputInterface? { get set }
    var wireframe: PersonListWireframeInterface? { get set }
    
}

protocol PersonListInteractorInputInterface: BaseInteractorInterface {
    var output: PersonListInteractorOutputInterface? { get set }
    
}

protocol PersonListInteractorOutputInterface {
    
}

protocol PersonListWireframeInterface: BaseWireframeInterface {
    
    static func buildModule() -> UIViewController
}
