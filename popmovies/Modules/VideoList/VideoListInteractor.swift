//
//  VideoListInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: VideoListInteractor: BaseInteractor

class VideoListInteractor: BaseInteractor {
    
    var output: VideoListInteractorOutputInterface?
    
    init(output: VideoListInteractorOutputInterface?) {
        self.output = output
    }
}

// MARK: VideoListInteractorInputInterface

extension VideoListInteractor: VideoListInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {}
}
