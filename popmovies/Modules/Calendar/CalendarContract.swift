
//
//  CalendarContract.swift
//  popmovies
//
//  Created by Tiago Silva on 06/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

protocol CalendarViewInterface: BaseViewInterface {
    var presenter: CalendarPresenterInterface? { get set }
    
}

protocol CalendarPresenterInterface: BasePresenterInterface {
    
    var view: CalendarViewInterface? { get set }
    var interactor: CalendarInteractorInputInterface? { get set }
    var wireframe: CalendarWireframeInterface? { get set }
    
}

protocol CalendarInteractorInputInterface: BaseInteractorInterface {
    var output: CalendarInteractorOutputInterface? { get set }
    
}

protocol CalendarInteractorOutputInterface {
    
}

protocol CalendarWireframeInterface: BaseWireframeInterface {
    
    static func buildModule() -> UIViewController
}
