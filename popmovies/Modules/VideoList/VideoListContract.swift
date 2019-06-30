//
//  VideoListContract.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import RxSwift

protocol VideoListViewInterface: BaseViewInterface {
    var presenter: VideoListPresenterInterface? { get set }
    
}

protocol VideoListPresenterInterface: BasePresenterInterface {
    
    var view: VideoListViewInterface? { get set }
    var interactor: VideoListInteractorInputInterface? { get set }
    var wireframe: VideoListWireframeInterface? { get set }
    
    func didSelectVideo(_ video: Video, indexPath: IndexPath)
}

protocol VideoListInteractorInputInterface: BaseInteractorInterface {
    var output: VideoListInteractorOutputInterface? { get set }
    
}

protocol VideoListInteractorOutputInterface {
    
}

protocol VideoListWireframeInterface {
    
    var viewController: UIViewController? { get set }
    
    func presentVideoViewer(for video: Video, _ allVideos: [Video], _ movie: Movie?,_ person: Person?)
    
    static func buildModule(_ allVideos: [Video], _ movie: Movie?, _ person: Person?) -> UIViewController
    static func buildModule() -> UIViewController
}
