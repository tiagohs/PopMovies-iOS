//
//  PersonServiceInterface.swift
//  popmovies
//
//  Created by Tiago Silva on 06/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import RxSwift
import RxAlamofire

// MARK: PersonServiceInterface

protocol PersonServiceInterface {
    
    func getDetails(personId: Int, appendToResponse: [String], language: String) -> Observable<Person>
    func getPersonList(url: String, paramenters: [String : String]) -> Observable<Results<Person>>
    func getImages(personId: Int) -> Observable<ImageResults>
    func getTaggedImages(_ personId: Int, language: String) -> Observable<TaggedImages>
    func getTranslations(_ personId: Int) -> Observable<TranslationResults>
    func getAllImages(personId: Int, language: String) -> Observable<ImageResultDTO>
}
