
//
//  CalendarWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 06/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: CalendarWireframe: CalendarWireframeInterface

class CalendarWireframe: CalendarWireframeInterface {
    
    weak var viewController: UIViewController?
    
}

// MARK: build's Module

extension CalendarWireframe {
    
    static func buildModule() -> UIViewController {
        let wireframe = CalendarWireframe()
        let view = R.storyboard.calendar.calendarController()
        let presenter = CalendarPresenter(view: view)
        let interactor = CalendarInteractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }

}
