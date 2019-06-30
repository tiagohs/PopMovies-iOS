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
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
        self.interactor = nil
        self.view = nil
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

// MARK: VideoListInteractorOutputInterface

extension VideoListPresenter: VideoListInteractorOutputInterface {
    
}
