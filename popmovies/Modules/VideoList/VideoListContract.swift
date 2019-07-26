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
    
    func bindUI(_ posterPath: String?, _ quantityContent: String, _ title: String?) 
    
    func showVideos(with videos: [Video])
}

protocol VideoListPresenterInterface: BasePresenterInterface {
    
    var view: VideoListViewInterface? { get set }
    var interactor: VideoListInteractorInputInterface? { get set }
    var wireframe: VideoListWireframeInterface? { get set }
    
    func didSelectVideo(_ video: Video, indexPath: IndexPath)
    
    func fetchVideos(_ movieId: Int?)
}

protocol VideoListInteractorInputInterface: BaseInteractorInterface {
    var output: VideoListInteractorOutputInterface? { get set }
    
    func fetchVideos(_ movieId: Int)
}

protocol VideoListInteractorOutputInterface {
    
    func didVideosFetch(with videos: VideoResultDTO)
    func didVideosFetch(with error: Error)
}

protocol VideoListWireframeInterface: BaseWireframeInterface {
    
    func presentVideoViewer(for video: Video, _ allVideos: [Video], _ movie: Movie?,_ person: Person?)
    
    static func buildModule(_ allVideos: [Video], _ movie: Movie?, _ person: Person?) -> UIViewController
    static func buildModule() -> UIViewController
}
