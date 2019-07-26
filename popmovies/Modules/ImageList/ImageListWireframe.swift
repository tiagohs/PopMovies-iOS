//
//  ImageListWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: ImageListWireframe: ImageListWireframaInterface

class ImageListWireframe: ImageListWireframaInterface {
    
    weak var viewController: UIViewController?
    
    func presentImageViewer(for image: Image, _ allImages: [Image], _ movie: Movie?,_ person: Person?, indexPath: IndexPath) {
        let imageListModule = ImageViewerWireframe.buildModule(image, allImages: allImages, indexPath, movie, person)
        
        imageListModule.hero.modalAnimationType = .fade
        self.viewController?.present(imageListModule, animated: true, completion: nil)
    }
    
}

// MARK: build's Module

extension ImageListWireframe {
    
    static func buildModule(_ allImages: [Image], person: Person?, _ movie: Movie?) -> UIViewController {
        let module = ImageListWireframe.buildModule() as! ImageListController
        let presenter = module.presenter as! ImageListPresenter
        
        module.allImages = allImages
        
        presenter.allImages = allImages
        presenter.person = person
        presenter.movie = movie
        
        return module
    }
    
    static func buildModule(person: Person?, _ movie: Movie?) -> UIViewController {
        let module = ImageListWireframe.buildModule() as! ImageListController
        let presenter = module.presenter as! ImageListPresenter
        
        presenter.person = person
        presenter.movie = movie
        
        return module
    }
    
    static func buildModule() -> UIViewController {
        let wireframe = ImageListWireframe()
        let view = R.storyboard.imageList.imageListController()
        let presenter = ImageListPresenter(view: view) 
        let interactor = ImageListInteractor(output: presenter)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        interactor.output = presenter
        wireframe.viewController = view
        
        return view!
    }
    
}
