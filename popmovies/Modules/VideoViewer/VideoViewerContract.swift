//
//  VideoViewerContract.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

protocol VideoViewerViewInterface: BaseViewInterface {
    
    var presenter: VideoViewerPresenterInterface? { get set }
    
    func setupVideoVewer(with youtubeKey: String, _ videoID: String)
    func setupVideoFrame()
}

protocol VideoViewerPresenterInterface: BasePresenterInterface {
    
    var view: VideoViewerViewInterface? { get set }
    var interactor: VideoViewerInteractorInputInterface? { get set }
    var wireframe: VideoViewerWireframaInterface? { get set }
    
    func viewWillLayoutSubviews()
}

protocol VideoViewerInteractorInputInterface: BaseInteractorInterface {
    var output: VideoViewerInteractorOutputInterface? { get set }
    
}

protocol VideoViewerInteractorOutputInterface {
    
}

protocol VideoViewerWireframaInterface: BaseWireframeInterface {
    
    func pushToVideoList(_ allVideos: [Video], _ movie: Movie?, _ person: Person?)
    
    static func buildModule(_ video: Video) -> UIViewController
    static func buildModule() -> UIViewController
}
