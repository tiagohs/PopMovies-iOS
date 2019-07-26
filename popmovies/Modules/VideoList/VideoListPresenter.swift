//
//  VideoListPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: VideoListPresenter

class VideoListPresenter {
    
    // MARK: Properties
    
    var view: VideoListViewInterface?
    var interactor: VideoListInteractorInputInterface?
    var wireframe: VideoListWireframeInterface?
    
    var allVideos: [Video] = []
    
    var movie: Movie?
    var person: Person?
    
    init(view: VideoListViewInterface?) {
        self.view = view
    }
    
}

// MARK: VideoListPresenterInterface - Lifecycle methods

extension VideoListPresenter: VideoListPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
        
        if self.allVideos.isEmpty {
            self.fetchVideos(movie?.id)
        }
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
}

// MARK: VideoListPresenter - Prepare UI

extension VideoListPresenter {
    
    func didSelectVideo(_ video: Video, indexPath: IndexPath) {
        wireframe?.presentVideoViewer(for: video, allVideos, movie, person)
    }
    
}

extension VideoListPresenter {
    
    func fetchVideos(_ movieId: Int?) {
        guard let id = movieId else {
            self.view?.onError(message: R.string.localizable.unknownError())
            return
        }
        
        self.view?.showActivityIndicator()
        self.interactor?.fetchVideos(id)
    }
}

// MARK: VideoListInteractorOutputInterface

extension VideoListPresenter: VideoListInteractorOutputInterface {
    
    func didVideosFetch(with videoResultDTO: VideoResultDTO) {
        let videoQuantity = videoResultDTO.videos.count
        let languageQuantity = videoResultDTO.translations.count
        let quantityContent = "\(String(describing: videoQuantity)) \(R.string.localizable.videoListTitle()) / \(String(describing: languageQuantity)) \(R.string.localizable.languages()) "
        
        self.allVideos = videoResultDTO.videos
        
        self.view?.hideActivityIndicator()
        self.view?.bindUI(movie?.posterPath, quantityContent, movie?.title)
        self.view?.showVideos(with: allVideos)
    }
    
    func didVideosFetch(with error: Error) {
        self.view?.hideActivityIndicator()
        self.view?.onError(message: error.localizedDescription)
    }
}
