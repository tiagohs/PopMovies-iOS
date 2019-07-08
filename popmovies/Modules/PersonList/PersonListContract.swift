
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
    
    func showPersons(with persons: [Person])
}

protocol PersonListPresenterInterface: BasePresenterInterface {
    
    var view: PersonListViewInterface? { get set }
    var interactor: PersonListInteractorInputInterface? { get set }
    var wireframe: PersonListWireframeInterface? { get set }
    
    func fetchPersons()
    
    func didSelectPerson(_ person: Person)
}

protocol PersonListInteractorInputInterface: BaseInteractorInterface {
    var output: PersonListInteractorOutputInterface? { get set }
    
    func fetchPersons(from url: String,with parameters: [String : String ])
}

protocol PersonListInteractorOutputInterface {
    
    func personsDidFetch(_ persons: [Person], totalPages: Int)
    func personsDidError(_ error: DefaultError)
}

protocol PersonListWireframeInterface: BaseWireframeInterface {
    
    func presentDetails(for person: Person) 
    
    static func buildModule() -> UIViewController
}
