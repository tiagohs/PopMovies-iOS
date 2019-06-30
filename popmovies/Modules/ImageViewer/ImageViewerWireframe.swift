//
//  ImageViewerWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: ImageViewerWireframe: ImageViewerWireframaInterface

class ImageViewerWireframe: ImageViewerWireframaInterface {
    weak var viewController: UIViewController?
    
    func pushToImageList(allImages: [Image], _ movie: Movie?, _ person: Person?) {
        let imageListModule = ImageListWireframe.buildModule(allImages, person: person, movie)
        
        imageListModule.hero.modalAnimationType = .fade
        self.viewController?.present(imageListModule, animated: true, completion: nil)
    }
    
}

// MARK: build's Module

extension ImageViewerWireframe {
    
    static func buildModule(_ image: Image, allImages: [Image], _ indexPath: IndexPath, _ movie: Movie?, _ person: Person?) -> UIViewController {
        let imageViewerModule = ImageViewerWireframe.buildModule() as! ImageViewerController
        let presenter = imageViewerModule.presenter as! ImageViewerPresenter
        
        imageViewerModule.allImages = allImages
        imageViewerModule.image = image
        imageViewerModule.selectedIndex = indexPath
        
        presenter.allImages = allImages
        presenter.image = image
        presenter.movie = movie
        presenter.person = person
        
        return imageViewerModule
    }
    
    static func buildModule() -> UIViewController {
        let wireframe = ImageViewerWireframe()
        let view = R.storyboard.main.imageViewerController()
        let presenter = ImageViewerPresenter(view: view)
        let interactor = ImageViewerInteractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }
}
