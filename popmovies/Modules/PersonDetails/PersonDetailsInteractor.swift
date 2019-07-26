//
//  PersonDetailsInteractor.swift
//  popmovies
//
//  Created by Tiago Silva on 19/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

// MARK: PersonDetailsInteractor: BaseInteractor

class PersonDetailsInteractor: BaseInteractor {
    let personService: PersonServiceInterface
    
    var output: PersonDetailsInteractorOutputInterface?
    
    init(output: PersonDetailsInteractorOutputInterface?) {
        self.output = output
        self.personService = PersonService()
    }
    
}

// MARK: HomeInteractorInputInterface - Output lifecycle Methods

extension PersonDetailsInteractor: PersonDetailsInteractorInputInterface {
    
    func outputDidLoad() {}
    
    func outputFinished() {}
    
    func buildPersonFilmography(_ person: Person) {
        add(self.createFilmographyDTO(person)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (listOfFilmographyDTO) in
                self.output?.personFilmographyBuilded(with: listOfFilmographyDTO)
            }, onError: { (error) in
                self.output?.personFilmographyBuilded(with: DefaultError(message: R.string.localizable.unknownError()))
            })
        )
    }
    
    private func createFilmographyDTO(_ person: Person) -> Observable<[FilmographyDTO]> {
        return Observable<[FilmographyDTO]>.create { (observer) -> Disposable in
            let allCredits = self.mergeAllCredits(person.movieCredits)
            let creditsByMovie = Dictionary(grouping: allCredits, by: { $0.movieId })
            let listOfFilmographyDTO = creditsByMovie.map { (dictionary) -> FilmographyDTO in
                return FilmographyDTO(dictionary)
            }
            
            observer.onNext(listOfFilmographyDTO)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    private func mergeAllCredits(_ movieCredits: MovieCredits?) -> [FilmographyMovieItem] {
        let castItems = movieCredits?.cast?.map({ (creditCast) -> FilmographyMovieItem in
            let department = "\(R.string.localizable.acting()) (\(String(describing: creditCast.character ?? "")))"
            let movie = Movie()
            
            movie.id = creditCast.id
            movie.title = creditCast.title
            movie.posterPath = creditCast.posterPath
            movie.backdropPath = creditCast.backdropPath
            movie.releaseDate = creditCast.releaseDate
            
            return FilmographyMovieItem(creditCast.id, movie, department)
        }) ?? []
        let crewItems = movieCredits?.crew?.map({ (creditCrew) -> FilmographyMovieItem in
            let department = "\(String(describing: creditCrew.department ?? ""))"
            let movie = Movie()
            
            movie.id = creditCrew.id
            movie.title = creditCrew.title
            movie.posterPath = creditCrew.posterPath
            movie.backdropPath = creditCrew.backdropPath
            movie.releaseDate = creditCrew.releaseDate
            
            return FilmographyMovieItem(creditCrew.id, movie, department)
        }) ?? []
        
        return Array(castItems + crewItems)
    }
    
}

// MARK: HomeInteractorInputInterface - Fetch methods

extension PersonDetailsInteractor {
    
    func fetchPersonDetails(_ personId: Int) {
        let appendToResponse = [
            TMDB.Parameters.tagged_images,
            TMDB.Parameters.images,
            TMDB.Parameters.movie_credits,
            TMDB.Parameters.external_ids]
        
        add(personService.getDetails(personId: personId, appendToResponse: appendToResponse, language: "en,pt_BR,null")
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (person) in
                self.output?.personDetailsDidFetch(person)
            }, onError: { (error) in
                self.output?.personDetailsDidError(DefaultError(message: R.string.localizable.personsDetailsNotFound()))
            })
        )
    }
}
