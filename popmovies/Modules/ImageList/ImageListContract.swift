//
//  ImageListContract.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation


import UIKit

protocol ImageListViewInterface: BaseViewInterface {
    
    var presenter: ImageListPresenterInterface? { get set }
    
    func bindUI(_ posterPath: String?, _ imageQuantity: String, _ title: String)
    func showImages(from images: [Image])
}

protocol ImageListPresenterInterface: BasePresenterInterface {
    
    var view: ImageListViewInterface? { get set }
    var interactor: ImageListInteractorInputInterface? { get set }
    var wireframe: ImageListWireframaInterface? { get set }
    
    func didSelectImage(_ image: Image, indexPath: IndexPath)
}

protocol ImageListInteractorInputInterface: BaseInteractorInterface {
    var output: ImageListInteractorOutputInterface? { get set }
    
    func fetchImages(fromMovie id: Int)
    func fetchImages(fromPerson id: Int)
}

protocol ImageListInteractorOutputInterface {
    
    func didImagesFetch(with imagesDTO: ImageResultDTO)
    func didImagesFetch(with error: DefaultError)
}

protocol ImageListWireframaInterface: BaseWireframeInterface {
    
    func presentImageViewer(for image: Image, _ allImages: [Image], _ movie: Movie?,_ person: Person?, indexPath: IndexPath)
    
    static func buildModule(_ allImages: [Image], person: Person?, _ movie: Movie?) -> UIViewController
    static func buildModule() -> UIViewController
}
