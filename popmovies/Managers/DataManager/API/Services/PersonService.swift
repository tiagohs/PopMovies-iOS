//
//  PersonService.swift
//  popmovies
//
//  Created by Tiago Silva on 19/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

// MARK: PersonService: PersonServiceInterface

class PersonService: PersonServiceInterface {
    
    func getDetails(personId: Int, appendToResponse: [String], language: String) -> Observable<Person> {
        let url = TMDB.URL.PERSON.buidPersonDetailsUrl(personId: personId)
        let parameters = TMDB.URL.PERSON.buildPersonDetailsParameters(appendToResponse, language)
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: Person.self)
    }
    
    func getPersonList(url: String, paramenters: [String : String]) -> Observable<Results<Person>> {
        
        return requestJSON(.get, url, parameters: paramenters)
            .debug()
            .mapObject(type: Results<Person>.self)
    }
    
    func getImages(personId: Int) -> Observable<Results<Image>> {
        let url = TMDB.URL.PERSON.buildImagesUrl(personId: personId)
        let parameters = TMDB.URL.PERSON.buildImagesParameters()
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: Results<Image>.self)
    }
    
    func getTaggedImages(_ personId: Int, language: String) -> Observable<TaggedImages> {
        let url = TMDB.URL.PERSON.buildTaggedImagesUrl(personId: personId)
        let parameters = TMDB.URL.PERSON.buildTaggedImagesParameters(language)
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: TaggedImages.self)
    }
    
    func getTranslations(_ personId: Int) -> Observable<TranslationResults>  {
        let url = TMDB.URL.PERSON.buildTranslationsPersonUrl(personId: personId)
        let parameters = TMDB.URL.MOVIES.buildTranslationsParameters()
        
        return requestJSON(.get, url, parameters: parameters)
            .debug()
            .mapObject(type: TranslationResults.self)
    }
    
    func getAllImages(personId: Int, language: String) -> Observable<ImageResultDTO> {
        let imageResultDTO = ImageResultDTO()
        
        imageResultDTO.translations = []
        imageResultDTO.images = []
        
        return
            getImages(personId: personId)
                .flatMap({ (imageResult) -> Observable<TranslationResults> in
                    imageResultDTO.images += imageResult.results ?? []
                    
                    return self.getTranslations(personId)
                })
                .concatMap({ (translationResult) -> Observable<TaggedImages> in
                    let translationDefault = Translation()
                    translationDefault.iso_639_1 = "null"
                    
                    translationResult.translationList?.append(translationDefault)
                    
                    return Observable.from(translationResult.translationList ?? [])
                                    .flatMap({ (translation) -> Observable<TaggedImages> in
                                        let language = translation.iso_639_1 != "null" ? "\(String(describing: translation.iso_639_1 ?? ""))_\(String(translation.iso_3166_1 ?? "")))" : "null"
                                        
                                        return self.getTaggedImages(personId, language: language)
                                                    .do(onNext: { (taggedImages) in
                                                        imageResultDTO.images += self.mergeImages(taggedImages)
                                                    })
                                    })
                    })
                .map({ (taggedImages) -> ImageResultDTO in return imageResultDTO })
    }
    
    private func mergeImages(_ taggedImages: TaggedImages) -> [Image] {
        let taggedImages = taggedImages.results?.map({ (taggedImagesResults) -> Image in
            let image = Image()
            image.filePath = taggedImagesResults.filePath
            
            return image
        }) ?? []
        
        return taggedImages
    }
}
