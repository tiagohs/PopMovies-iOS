//
//  VideoListWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class VideoListWireframe: VideoListWireframeInterface {
    weak var viewController: UIViewController?
    
    func presentVideoViewer(for video: Video, _ allVideos: [Video], _ movie: Movie?, _ person: Person?) {
        let videoViewer = VideoViewerWireframe.buildModule(video)
        
        videoViewer.hero.modalAnimationType = .fade
        self.viewController?.present(videoViewer, animated: true, completion: nil)
    }
    
}

extension VideoListWireframe {
    
    static func buildModule(_ allVideos: [Video], _ movie: Movie?, _ person: Person?) -> UIViewController {
        let module = VideoListWireframe.buildModule() as! VideoListController
        let presenter = module.presenter as! VideoListPresenter
        
        module.allVideos = allVideos
        
        presenter.allVideos = allVideos
        presenter.movie = movie
        presenter.person = person
        
        return module
    }
    
    static func buildModule() -> UIViewController {
        let wireframe = VideoListWireframe()
        let view = R.storyboard.videoList.videoListController()
        let presenter = VideoListPresenter(view: view)
        let interactor = VideoListInteractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }
}
