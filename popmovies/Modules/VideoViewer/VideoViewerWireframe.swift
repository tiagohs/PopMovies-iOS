//
//  VideoViewerWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: VideoViewerWireframe: VideoViewerWireframaInterface

class VideoViewerWireframe: VideoViewerWireframaInterface {
    
    weak var viewController: UIViewController?
    
    func pushToVideoList(_ allVideos: [Video], _ movie: Movie?, _ person: Person?) {
        let videoListModule = VideoListWireframe.buildModule(allVideos, movie, person)
        
        videoListModule.hero.modalAnimationType = .slide(direction: .left)
        self.viewController?.present(videoListModule, animated: true, completion: nil)
    }
    
}

// MARK: build's Module

extension VideoViewerWireframe {
    
    static func buildModule(_ video: Video) -> UIViewController {
        let videoViewerModule = VideoViewerWireframe.buildModule() as! VideoViewerController
        let presenter = videoViewerModule.presenter as! VideoViewerPresenter
        
        presenter.video = video
        
        return videoViewerModule
    }
    
    static func buildModule() -> UIViewController {
        let wireframe = VideoViewerWireframe()
        let view = R.storyboard.videoViewer.videoViewerController()
        let presenter = VideoViewerPresenter(view: view)
        let interactor = VideoViewerInteractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }
}
