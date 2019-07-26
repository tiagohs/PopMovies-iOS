//
//  PersonDetailsContract.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import RxSwift

protocol PersonDetailsViewInterface: BaseViewInterface {
    
    var presenter: PersonDetailsPresenterInterface? { get set }

    func showPerson(with person: Person)
    func showPersonFilmography(with filmographyList: [FilmographyDTO])
}

protocol PersonDetailsPresenterInterface: BasePresenterInterface {

    var view: PersonDetailsViewInterface? { get set }
    var interactor: PersonDetailsInteractorInputInterface? { get set }
    var wireframe: PersonDetailsWireframsInterface? { get set }
    
    func fetchPersonDetails()
    
    func didLinkClicked(with url: String)
    func didSelectMovie(_ movie: Movie)
    func didImageSelect(_ image: Image, indexPath: IndexPath)
    func didSeeAllMoviesClicked()
    func didSeeAllImagesClicked()
}

protocol PersonDetailsInteractorInputInterface: BaseInteractorInterface {
    var output: PersonDetailsInteractorOutputInterface? { get set }

    func fetchPersonDetails(_ personId: Int)
    func buildPersonFilmography(_ person: Person)
}

protocol PersonDetailsInteractorOutputInterface {
    
    func personDetailsDidFetch(_ person: Person)
    func personDetailsDidError(_ error: DefaultError)
    func personFilmographyBuilded(with filmographyMovies: [FilmographyDTO])
    func personFilmographyBuilded(with error: DefaultError)
}

protocol PersonDetailsWireframsInterface: BaseWireframeInterface {
    
    func presentExternalLink(from url: String)
    func presentDetails(for movie: Movie)
    func presentImageViewer(for image: Image, _ allImages: [Image], _ person: Person, indexPath: IndexPath)
    func pushToImageList(_ allImages: [Image], _ person: Person)
    func pushToMovieList(_ allMovies: [Movie], _ person: Person)
    
    static func buildModule(with person: Person) -> UIViewController
    static func buildModule() -> UIViewController
}
