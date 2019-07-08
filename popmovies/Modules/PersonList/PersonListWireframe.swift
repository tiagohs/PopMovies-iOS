
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
    
    func presentDetails(for person: Person) {
        let personDetailsModule = PersonDetailsWireframe.buildModule(with: person)
        
        self.viewController?.hero.modalAnimationType = .slide(direction: .left)
        self.viewController?.present(personDetailsModule, animated: true, completion: nil)
    }
}

// MARK: build's Module

extension PersonListWireframe {
    
    static func buildModule() -> UIViewController {
        let wireframe = PersonListWireframe()
        let view = R.storyboard.personList.personListController()
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
