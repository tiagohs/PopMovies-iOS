//
//  VideoListInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: VideoListInteractor: BaseInteractor

class VideoListInteractor: BaseInteractor {
    
    let movieService: MovieService!
    var output: VideoListInteractorOutputInterface?
    
    init(output: VideoListInteractorOutputInterface?) {
        self.output = output
        self.movieService = MovieService()
    }
}

// MARK: VideoListInteractorInputInterface

extension VideoListInteractor: VideoListInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {}
}

extension VideoListInteractor {
    
    func fetchVideos(_ movieId: Int) {
        var videoDTOFinal: VideoResultDTO?
        
        add(movieService.getAllVideos(movieId: movieId, language: "pt_BR")
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (videoDTO) in
                videoDTOFinal = videoDTO
            }, onError: { (error) in
                self.onError()
            }, onCompleted: {
                self.output?.didVideosFetch(with: videoDTOFinal!)
            })
        )
    }
    
    private func onError(message: String = R.string.localizable.videosNotFound()) {
        self.output?.didVideosFetch(with: DefaultError(message: message))
    }
}
