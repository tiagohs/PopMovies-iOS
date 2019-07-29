//
//  WeekContract.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

protocol WeekViewInterface: BaseViewInterface {
    var presenter: WeekPresenterInterface? { get set }
        
    func showMovies(_ movies: [Movie])
    func updateDates(_ startDate: Date, _ endDate: Date)
    
    func formatDates(_ startDateFormat: String, _ endDateFormat: String, _ monthAndYear : String)
}

protocol WeekPresenterInterface: BasePresenterInterface {
    
    var view: WeekViewInterface? { get set }
    var interactor: WeekInteractorInputInterface? { get set }
    var wireframe: WeekWireframeInterface? { get set }
    
    func fetchMoviesFromCurrentWeek(startDate: Date, endDate: Date, _ locale: LocaleDTO?)
    
    func didSelectNewDate(_ startDate: Date, _ endDate: Date, _ locale: LocaleDTO?)
    func didSelectDateFromCalendarClicked()
    func didSelectMovie(_ movie: Movie)
    func didNextClicked()
    func didPreviousClicked()
}

protocol WeekInteractorInputInterface: BaseInteractorInterface {
    var output: WeekInteractorOutputInterface? { get set }
    
    func fetchMoviesFromCurrentWeek(discoverModel: DiscoverMovie, page: Int, language: LocaleDTO)
}

protocol WeekInteractorOutputInterface {
    
    func moviesFromCurrentWeekDidFetch(_ movies: [Movie])
    func moviesFromCurrentWeekDidError(_ error: DefaultError)
}

protocol WeekWireframeInterface: BaseWireframeInterface {
    
    func presentCalendar()
    func presentDetails(for movie: Movie)
    
    static func buildModule() -> UIViewController
}
