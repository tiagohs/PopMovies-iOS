//
//  PersonDetailsWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: PersonDetailsWireframe: PersonDetailsWireframsInterface

class PersonDetailsWireframe: PersonDetailsWireframsInterface {
    
    weak var viewController: UIViewController?
    
    func presentExternalLink(from url: String) {
        guard let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let encondedURL = URL(string: encoded) else {
                return
        }
        
        UIApplication.shared.open(encondedURL)
    }
    
    func presentDetails(for movie: Movie) {
        let movieDetailsModule = MovieDetailsWireframe.buildModule(with: movie)
        
        self.viewController?.present(movieDetailsModule, animated: true, completion: nil)
    }
    
    func presentImageViewer(for image: Image, _ allImages: [Image], _ person: Person, indexPath: IndexPath) {
        let imageViewerModule = ImageViewerWireframe.buildModule(image, allImages: allImages, indexPath, nil, person)
        
        imageViewerModule.hero.modalAnimationType = .fade
        
        self.viewController?.present(imageViewerModule, animated: true, completion: nil)
    }
    
    func pushToMovieList(_ allMovies: [Movie], _ person: Person) {
        let title = person.name ?? "Movie List"
        let movieListModule = MovieListWireframe.buildModuleFromUINavigation(with: allMovies, title: title)
        
        movieListModule.hero.modalAnimationType = .slide(direction: .left)
        self.viewController?.present(movieListModule, animated: true, completion: nil)
    }
    
    func pushToImageList(_ allImages: [Image], _ person: Person) {
        let imageListModule = ImageListWireframe.buildModule(allImages, person: person, nil)
        
        imageListModule.hero.modalAnimationType = .fade
        self.viewController?.present(imageListModule, animated: true, completion: nil)
    }
}

// MARK: build's Module

extension PersonDetailsWireframe {
    
    static func buildModule(with person: Person) -> UIViewController {
        let module = buildModule() as! PersonDetailsController
        let presenter = module.presenter as! PersonDetailsPresenter
        
        module.person = person
        
        presenter.person = person
        
        return module
    }
    
    static func buildModule() -> UIViewController {
        let wireframe = PersonDetailsWireframe()
        let view = R.storyboard.personDetails.personDetails()
        let presenter = PersonDetailsPresenter(view: view)
        let interactor = PersonDetailsInteractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }
    
}
