//
//  ImageViewerPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: ImageViewerPresenter

class ImageViewerPresenter {
    
    var view: ImageViewerViewInterface?
    var interactor: ImageViewerInteractorInputInterface?
    var wireframe: ImageViewerWireframaInterface?
    
    var image: Image?
    var allImages: [Image] = []
    
    var person: Person?
    var movie: Movie?
    
    init(view: ImageViewerViewInterface?) {
        self.view = view
    }
}

// MARK: ImageViewerPresenterInterface - Lifecycle methods

extension ImageViewerPresenter: ImageViewerPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupButtons()
        self.view?.setupUI()
        self.view?.setupImageViewerCollectionView()
        
        
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
    func viewWillLayoutSubviews() {
        self.view?.setupImageCollectionViewCells() 
    }
}
// MARK: ImageViewerPresenterInterface - Clicks methods

extension ImageViewerPresenter {
    
    func didSeeAllImagesClicked() {
        wireframe?.pushToImageList(allImages: allImages, movie, person)
    }
}

// MARK: ImageViewerInteractorOutputInterface

extension ImageViewerPresenter: ImageViewerInteractorOutputInterface {
    
}
