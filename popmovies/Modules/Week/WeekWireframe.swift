//
//  WeekWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit


class WeekWireframe: WeekWireframeInterface {
    
    weak var viewController: UIViewController?
    
    func presentCalendar() {
        let calendarModule = CalendarWireframe.buildModule() as! CalendarController
        let weekController = self.viewController as! WeekController
        
        calendarModule.delegate = weekController
        
        self.viewController?.hero.modalAnimationType = .zoomSlide(direction: .up)
        self.viewController?.navigationController?.present(calendarModule, animated: true, completion: nil)

    }
    
    func presentDetails(for movie: Movie) {
        let movieDetailsModule = MovieDetailsWireframe.buildModule(with: movie)
        
        self.viewController?.navigationController?.present(movieDetailsModule, animated: true, completion: nil)
    }
    
}

extension WeekWireframe {
    
    static func buildModule() -> UIViewController {
        let view = R.storyboard.week.weekController()
        
        return build(view)
    }
    
    static func buildModuleFromUINavigation() -> UIViewController {
        let navigationController = R.storyboard.week.weekNavigationController()
        let view = navigationController?.viewControllers.first as! WeekController
        
        _ = build(view)
        
        return navigationController!
    }
    
    private static func build(_ view: WeekController?) -> UIViewController  {
        let wireframe = WeekWireframe()
        let presenter = WeekPresenter(view: view)
        let interactor = WeekInteractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }
}
