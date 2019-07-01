//
//  ImageViewerContract.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

protocol ImageViewerViewInterface: BaseViewInterface {
    
    var presenter: ImageViewerPresenterInterface? { get set }
    
    func setupButtons()
    func setupImageViewerCollectionView()
    func setupImageCollectionViewCells() 
}

protocol ImageViewerPresenterInterface: BasePresenterInterface {
    
    var view: ImageViewerViewInterface? { get set }
    var interactor: ImageViewerInteractorInputInterface? { get set }
    var wireframe: ImageViewerWireframaInterface? { get set }
    
    func viewWillLayoutSubviews()
    
    func didSeeAllImagesClicked()
}

protocol ImageViewerInteractorInputInterface: BaseInteractorInterface {
    var output: ImageViewerInteractorOutputInterface? { get set }
    
}

protocol ImageViewerInteractorOutputInterface {
    
}

protocol ImageViewerWireframaInterface {
    
    func pushToImageList(allImages: [Image], _ movie: Movie?, _ person: Person?)
    
    static func buildModule(_ image: Image, allImages: [Image], _ indexPath: IndexPath, _ movie: Movie?, _ person: Person?) -> UIViewController
    static func buildModule() -> UIViewController
}
