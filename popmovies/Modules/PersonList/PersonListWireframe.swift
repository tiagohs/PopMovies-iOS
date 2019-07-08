
//
//  PersonListWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 08/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: PersonListWireframe: PersonListWireframeInterface

class PersonListWireframe: PersonListWireframeInterface {
    
    weak var viewController: UIViewController?
    
    func presentDetails(for personItem: PersonItem) {
        let person = Person()
        
        person.id = personItem.id
        person.name = personItem.name
        person.profilePath = personItem.pictureId
        
        let personDetailsModule = PersonDetailsWireframe.buildModule(with: person)
        
        self.viewController?.hero.modalAnimationType = .slide(direction: .left)
        self.viewController?.present(personDetailsModule, animated: true, completion: nil)
    }
}

// MARK: build's Module

extension PersonListWireframe {
    
    static func buildModule(with persons: [PersonItem], title: String) -> UIViewController {
        let module = buildModule() as! PersonListController
        let presenter = module.presenter as! PersonListPresenter
        
        module.persons = persons
        presenter.persons = persons
        
        return module
    }
    
    static func buildModule(url: String, parameters: [String : String], title: String) -> UIViewController {
        let module = buildModule() as! PersonListController
        let presenter = module.presenter as! PersonListPresenter
        
        presenter.url = url
        presenter.parameters = parameters
        
        module.title = title
        
        return module
    }
    
    static func buildModuleFromUINavigation(with persons: [PersonItem], title: String) -> UIViewController {
        let moduleNavigation = buildModuleFromUINavigation() as! UINavigationController
        let module = moduleNavigation.viewControllers.first as! PersonListController
        let presenter = module.presenter as! PersonListPresenter
        
        module.persons = persons
        presenter.persons = persons
        
        return moduleNavigation
    }
    
    static func buildModuleFromUINavigation(url: String, parameters: [String : String], title: String) -> UIViewController {
        let moduleNavigation = buildModuleFromUINavigation() as! UINavigationController
        let module = moduleNavigation.viewControllers.first as! PersonListController
        let presenter = module.presenter as! PersonListPresenter
        
        presenter.url = url
        presenter.parameters = parameters
        
        module.title = title
        
        return moduleNavigation
    }
    
    static func buildModule() -> UIViewController {
        let view = R.storyboard.personList.personListController()
        
        return build(view)
    }
    
    static func buildModuleFromUINavigation() -> UIViewController {
        let navigationController = R.storyboard.personList.personListNavigationController()
        let view = navigationController?.viewControllers.first as! PersonListController
        
        _ = build(view)
        
        return navigationController!
    }
    
    private static func build(_ view: PersonListController?) -> UIViewController {
        let wireframe = PersonListWireframe()
        let presenter = PersonListPresenter(view: view)
        let interactor = PersonListInteractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }

}
