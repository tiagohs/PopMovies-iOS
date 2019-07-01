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
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

// MARK: ImageListPresenterInterface - Prepare UI

extension ImageListPresenter {
    
    func prepareUI() {
        let imageQuantity = "\(allImages.count) Images"
        
        if let movie = self.movie {
            let posterPath = movie.posterPath
            let title = movie.title ?? "Images"
            
            self.view?.bindUI(posterPath, imageQuantity, title)
            return
        }
        
        if let person = self.person {
            let posterPath = person.profilePath
            let title = person.name ?? "Images"
            
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

// MARK: ImageListInteractorOutputInterface

extension ImageListPresenter: ImageListInteractorOutputInterface {
    
}
