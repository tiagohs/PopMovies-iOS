//
//  ImageListInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: ImageListInteractor: BaseInteractor

class ImageListInteractor: BaseInteractor {
    let movieService: MovieServiceInterface
    let personService: PersonServiceInterface
    
    var output: ImageListInteractorOutputInterface?
    
    init(output: ImageListInteractorOutputInterface?) {
        self.output = output
        self.movieService = MovieService()
        self.personService = PersonService()
    }
}

// MARK: ImageListInteractorInputInterface - Lifecycle methods

extension ImageListInteractor: ImageListInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {}
    
}

extension ImageListInteractor {
    
    func fetchImages(fromMovie id: Int) {
        var imageFinalDTO: ImageResultDTO?
        
        add(self.movieService.getAllImages(movieId: id, language: Locale.getCurrentAppLangAndRegion())
                        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                        .observeOn(MainScheduler.instance)
                        .subscribe(onNext: { (imageDTO) in
                            imageFinalDTO = imageDTO
                        }, onError: { (error) in
                            self.onError()
                        }, onCompleted: {
                            self.output?.didImagesFetch(with: imageFinalDTO!)
                        })
        )
    }
    
    func fetchImages(fromPerson id: Int) {
        var imageFinalDTO: ImageResultDTO?
        
        add(self.personService.getAllImages(personId: id, language: Locale.getCurrentAppLangAndRegion())
                            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                            .observeOn(MainScheduler.instance)
                            .subscribe(onNext: { (imageDTO) in
                                imageFinalDTO = imageDTO
                            }, onError: { (error) in
                                self.onError()
                            }, onCompleted: {
                                self.output?.didImagesFetch(with: imageFinalDTO!)
                            })
        )
    }
    
    private func onError(message: String = R.string.localizable.imagesNotFound()) {
        self.output?.didImagesFetch(with: DefaultError(message: message))
    }
}
