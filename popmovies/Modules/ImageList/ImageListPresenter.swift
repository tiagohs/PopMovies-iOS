//
//  ImageListPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: ImageListPresenter

class ImageListPresenter {
    
    // MARK: Properties
    
    var view: ImageListViewInterface?
    var interactor: ImageListInteractorInputInterface?
    var wireframe: ImageListWireframaInterface?
    
    var allImages: [Image] = []
    
    var movie: Movie?
    var person: Person?
    
    init(view: ImageListViewInterface?) {
        self.view = view
    }
}

// MARK: ImageListPresenterInterface - Lifecycle methods

extension ImageListPresenter: ImageListPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
        self.prepareUI()
        
        if allImages.isEmpty && self.movie != nil {
            self.fetchMovieImages()
            return
        }
        
        if allImages.isEmpty && self.person != nil {
            self.fetchPersonImages()
            return
        }
        
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

// MARK: ImageListPresenterInterface - Prepare UI

extension ImageListPresenter {
    
    func prepareUI(_ imagesDTO: ImageResultDTO? = nil) {
        let imageQuantity = imagesDTO == nil ?
                        "\(allImages.count) \(R.string.localizable.imageListTitle())" :
                        "\(imagesDTO!.images.count) \(R.string.localizable.imageListTitle()) / \(imagesDTO!.translations.count) \(R.string.localizable.languages())"
        
        if let movie = self.movie {
            let posterPath = movie.posterPath
            let title = movie.title ?? R.string.localizable.imageListTitle()
            
            self.view?.bindUI(posterPath, imageQuantity, title)
            return
        }
        
        if let person = self.person {
            let posterPath = person.profilePath
            let title = person.name ?? R.string.localizable.imageListTitle()
            
            self.view?.bindUI(posterPath, imageQuantity, title)
        }
    }
}

// MARK: ImageListPresenterInterface - User click methods

extension ImageListPresenter {
    
    func didSelectImage(_ image: Image, indexPath: IndexPath) {
        wireframe?.presentImageViewer(for: image, allImages, movie, person, indexPath: indexPath)
    }
}

extension ImageListPresenter {
    
    func fetchMovieImages() {
        guard let id = self.movie?.id else {
            return
        }
        
        self.view?.showActivityIndicator()
        self.interactor?.fetchImages(fromMovie: id)
    }
    
    func fetchPersonImages() {
        guard let id = self.person?.id else {
            return
        }
        
        self.view?.showActivityIndicator()
        self.interactor?.fetchImages(fromPerson: id)
    }
}

// MARK: ImageListInteractorOutputInterface

extension ImageListPresenter: ImageListInteractorOutputInterface {
    
    func didImagesFetch(with imagesDTO: ImageResultDTO) {
        self.allImages = imagesDTO.images
        
        self.view?.hideActivityIndicator()
        
        self.prepareUI(imagesDTO)
        self.view?.showImages(from: self.allImages)
    }
    
    func didImagesFetch(with error: DefaultError) {
        self.view?.hideActivityIndicator()
        
        self.view?.onError(message: error.message)
    }
}
