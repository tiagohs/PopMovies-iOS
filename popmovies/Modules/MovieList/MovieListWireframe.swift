//
//  MovieListWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 29/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: MovieListWireframe: MovieListWireframeInterface

class MovieListWireframe: MovieListWireframeInterface {
    
    weak var viewController: UIViewController?
    
    func presentDetails(for movie: Movie) {
        let movieDetailsModule = MovieDetailsWireframe.buildModule(with: movie)
        
        self.viewController?.navigationController?.present(movieDetailsModule, animated: true, completion: nil)
    }
    
    func presentSearch() {
        let module = SearchWireframe.buildModule()
        
        self.viewController?.hero.modalAnimationType = .slide(direction: .left)
        self.viewController?.present(module, animated: true, completion: nil)
    }
}

// MARK: build's Module

extension MovieListWireframe {
    
    static func buildModule(url: String, parameters: [String : String], title: String) -> UIViewController {
        let module = buildModule() as! MovieListController
        let presenter = module.presenter as! MovieListPresenter
        
        presenter.url = url
        presenter.parameters = parameters
        
        module.title = title
        
        return module
    }
    
    static func buildModule(with movies: [Movie], title: String) -> UIViewController {
        let module = buildModule() as! MovieListController
        let presenter = module.presenter as! MovieListPresenter
        
        module.movies = movies
        presenter.movies = movies
        
        return module
    }
    
    static func buildModule() -> UIViewController {
        let view = R.storyboard.movieList.movieListController()
        
        return build(view)
    }
    
    static func buildModuleFromUINavigation() -> UIViewController {
        let navigationController = R.storyboard.movieList.movieListNavigationController()
        let view = navigationController?.viewControllers.first as! MovieListController
        
        _ = build(view)
        
        return navigationController!
    }
    
    static func buildModuleFromUINavigation(url: String, parameters: [String : String], title: String) -> UIViewController {
        let moduleNavigation = buildModuleFromUINavigation() as! UINavigationController
        let module = moduleNavigation.viewControllers.first as! MovieListController
        let presenter = module.presenter as! MovieListPresenter

        presenter.url = url
        presenter.parameters = parameters
        
        module.title = title
        
        return moduleNavigation
    }
    
    static func buildModuleFromUINavigation(with movies: [Movie], title: String) -> UIViewController {
        let moduleNavigation = buildModuleFromUINavigation() as! UINavigationController
        let module = moduleNavigation.viewControllers.first as! MovieListController
        let presenter = module.presenter as! MovieListPresenter

        module.movies = movies
        presenter.movies = movies
        
        return moduleNavigation
    }
    
    private static func build(_ view: MovieListController?) -> UIViewController {
        let wireframe = MovieListWireframe()
        let presenter = MovieListPresenter(view: view)
        let interactor = MovieListInteractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }
}
