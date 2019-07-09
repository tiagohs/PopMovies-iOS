
//
//  SearchWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 08/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: SearchWireframe: SearchWireframeInterface

class SearchWireframe: SearchWireframeInterface {
    
    weak var viewController: UIViewController?
    
    func presentDetails(for movie: Movie) {
        let movieDetailsModule = MovieDetailsWireframe.buildModule(with: movie)
        
        self.viewController?.hero.modalAnimationType = .slide(direction: .left)
        self.viewController?.show(movieDetailsModule, sender: nil)
    }
    
}

// MARK: build's Module

extension SearchWireframe {
    
    static func buildModule() -> UIViewController {
        let wireframe = SearchWireframe()
        let view = R.storyboard.search.searchController()
        let presenter = SearchPresenter(view: view)
        let interactor = SearchInteractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }

}
