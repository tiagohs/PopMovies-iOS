
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
    
    func showPersons(with persons: [PersonItem])
    
    func stopInfiniteScroll()
}

protocol PersonListPresenterInterface: BasePresenterInterface {
    
    var view: PersonListViewInterface? { get set }
    var interactor: PersonListInteractorInputInterface? { get set }
    var wireframe: PersonListWireframeInterface? { get set }
    
    func fetchPersons()
    
    func didSelectPerson(_ person: PersonItem)
}

protocol PersonListInteractorInputInterface: BaseInteractorInterface {
    var output: PersonListInteractorOutputInterface? { get set }
    
    func fetchPersons(from url: String,with parameters: [String : String ])
}

protocol PersonListInteractorOutputInterface {
    
    func personsDidFetch(_ persons: [PersonItem], totalPages: Int)
    func personsDidError(_ error: DefaultError)
}

protocol PersonListWireframeInterface: BaseWireframeInterface {
    
    func presentDetails(for person: PersonItem) 
    
    static func buildModule(with persons: [PersonItem], title: String) -> UIViewController
    static func buildModule(url: String, parameters: [String : String], title: String) -> UIViewController
    
    static func buildModuleFromUINavigation(with persons: [PersonItem], title: String) -> UIViewController
    static func buildModuleFromUINavigation(url: String, parameters: [String : String], title: String) -> UIViewController
    
    static func buildModule() -> UIViewController
    static func buildModuleFromUINavigation() -> UIViewController
}
