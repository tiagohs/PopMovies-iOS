//
//  GenresWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: GenreListWireframe: GenreListWireframeInterface

class GenreListWireframe: GenreListWireframeInterface {
    weak var viewController: UIViewController?
    
    func pushToMovieListByGenre(_ genre: Genre) {
        guard let id = genre.id else {
            return
        }
        
        let url = TMDB.URL.GENRES.buildMovieListByGenreUrl(id)
        let parameters = TMDB.URL.GENRES.buildMovieListByGenreParameters("BR", 1, "pt_BR")
        let title = genre.name ?? "Movies"
        
        let movieListModule = MovieListWireframe.buildModule(url: url, parameters: parameters, title: title)
        
        self.viewController?.navigationController?.pushViewController(movieListModule, animated: true)
    }
    
}

// MARK: build's Module

extension GenreListWireframe {
    
    static func buildModule() -> UIViewController {
        let view = R.storyboard.genreList.genreListController()
        return build(view)
    }
    
    static func buildModuleFromUINavigation() -> UIViewController {
        let navigationController = R.storyboard.genreList.genreNavigationController()
        let view = navigationController?.viewControllers.first as! GenreListController
        
        _ = build(view)
        
        return navigationController!
    }
    
    private static func build(_ view: GenreListController?) -> UIViewController  {
        let wireframe = GenreListWireframe()
        let presenter = GenreListPresenter(view: view)
        let interactor = GenreListIntractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }
}
