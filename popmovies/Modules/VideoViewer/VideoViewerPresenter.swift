//
//  VideoViewerPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: VideoViewerPresenter

class VideoViewerPresenter {
    
    var view: VideoViewerViewInterface?
    var interactor: VideoViewerInteractorInputInterface?
    var wireframe: VideoViewerWireframaInterface?
    
    var video: Video?
    
    init(view: VideoViewerViewInterface?) {
        self.view = view
    }
}

// MARK: VideoViewerPresenterInterface - Lifecycle methods

extension VideoViewerPresenter: VideoViewerPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
        
        guard let video = self.video, let youtubeKey = video.key, let videoID = video.id else {
            self.view?.onError(message: R.string.localizable.unknownError())
            return
        }
        
        self.view?.setupVideoVewer(with: youtubeKey, videoID)
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
    func viewWillLayoutSubviews() {
        self.view?.setupVideoFrame()
    }
}

// MARK: VideoViewerInteractorOutputInterface

extension VideoViewerPresenter: VideoViewerInteractorOutputInterface {
    
}
