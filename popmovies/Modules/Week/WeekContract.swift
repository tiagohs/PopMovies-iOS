//
//  WeekContract.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

protocol WeekViewInterface: BaseViewInterface {
    var presenter: WeekPresenterInterface? { get set }
    
}

protocol WeekPresenterInterface: BasePresenterInterface {
    
    var view: WeekViewInterface? { get set }
    var interactor: WeekInteractorInputInterface? { get set }
    var wireframe: WeekWireframeInterface? { get set }
    
}

protocol WeekInteractorInputInterface: BaseInteractorInterface {
    var output: WeekInteractorOutputInterface? { get set }
    
}

protocol WeekInteractorOutputInterface {
    
}

protocol WeekWireframeInterface: BaseWireframeInterface {
    
    static func buildModule() -> UIViewController
}
