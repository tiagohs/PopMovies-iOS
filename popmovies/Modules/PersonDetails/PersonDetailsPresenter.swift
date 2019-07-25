//
//  PersonDetailsPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import RxSwift

 // MARK: PersonDetailsPresenter

class PersonDetailsPresenter {
    
     // MARK: Properties
    
    var view: PersonDetailsViewInterface?
    var interactor: PersonDetailsInteractorInputInterface?
    var wireframe: PersonDetailsWireframsInterface?
    
    var person: Person?
    
    init(view: PersonDetailsViewInterface?) {
        self.view = view
    }
    
}


// MARK: PersonDetailsPresenterInterface - Lifecycle methods

extension PersonDetailsPresenter: PersonDetailsPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
        
        self.fetchPersonDetails()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

// MARK: PersonDetailsPresenterInterface - Fetch methods

extension PersonDetailsPresenter {
    
    func fetchPersonDetails() {
        guard let personId = self.person?.id else {
            self.view?.onError(message: R.string.localizable.personsDetailsNotFound())
            return
        }
        
        self.interactor?.fetchPersonDetails(personId)
    }
    
}

// MARK: PersonDetailsPresenter - User click methods

extension PersonDetailsPresenter {
    
    func didSelectMovie(_ movie: Movie) {
        wireframe?.presentDetails(for: movie)
    }
    
    func didImageSelect(_ image: Image, indexPath: IndexPath) {
        guard let person = self.person, !person.allImages.isEmpty else {
            self.view?.onError(message: R.string.localizable.personsImagesNotFound())
            return
        }
        
        wireframe?.presentImageViewer(for: image, person.allImages, person, indexPath: indexPath)
    }
    
    func didSeeAllImagesClicked() {
        guard let person = self.person, !person.allImages.isEmpty else {
            return
        }
        
        wireframe?.pushToImageList(person.allImages, person)
    }
    
    func didLinkClicked(with url: String) {
        wireframe?.presentExternalLink(from: url)
    }
    
    func didSeeAllMoviesClicked() {
        guard let person = self.person,
            !person.allMovieCredits.isEmpty else {
            return
        }
        
        wireframe?.pushToMovieList(person.allMovieCredits, person)
    }
    
}

// MARK: PersonDetailsInteractorOutputInterface

extension PersonDetailsPresenter: PersonDetailsInteractorOutputInterface {
    
    func personDetailsDidFetch(_ person: Person) {
        self.person = person
        
        self.view?.showPerson(with: person)
    }
    
    func personDetailsDidError(_ error: DefaultError) {
        self.view?.onError(message: error.message)
    }
    
}
