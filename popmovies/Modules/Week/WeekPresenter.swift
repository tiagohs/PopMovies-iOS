//
//  WeekPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: WeekPresenter

class WeekPresenter {
    
    var view: WeekViewInterface?
    var interactor: WeekInteractorInputInterface?
    var wireframe: WeekWireframeInterface?
    
    var movies: [Movie] = []
    
    var startDate: Date?
    var endDate: Date?
    
    init(view: WeekViewInterface?) {
        self.view = view
    }
    
}

// MARK: WeekPresenterInterface - Lifecycle

extension WeekPresenter: WeekPresenterInterface {
    
    func viewDidLoad() {
        let today = Date()
        
        self.view?.setupUI()
        startDate = today.startOfWeek
        endDate = today.endOfWeek
        
        if  let startDate = startDate,
            let endDate = endDate {
            didSelectNewDate(startDate, endDate)
        }
        
    }
    
    func viewDidDisappear(_ animated: Bool) {
        
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

// MARK: Fetch methods

extension WeekPresenter {
    
    func fetchMoviesFromCurrentWeek(startDate: Date, endDate: Date) {
        let discoverModel = DiscoverMovie()
        
        discoverModel.withReleaseType = "2|3"
        discoverModel.releaseDateGte = startDate.formatDate(pattner: "yyyy-MM-dd")
        discoverModel.releaseDateLte = endDate.formatDate(pattner: "yyyy-MM-dd")
        discoverModel.region = "US"
        discoverModel.appendToResponse = ["credits"]
        
        interactor?.fetchMoviesFromCurrentWeek(discoverModel: discoverModel, page: 1)
    }
    
}

// MARK: WeekPresenterInterface - User click methods

extension WeekPresenter {
    
    func didSelectDateFromCalendarClicked() {
        wireframe?.presentCalendar()
    }
    
    func didSelectMovie(_ movie: Movie) {
        wireframe?.presentDetails(for: movie)
    }
    
    func didNextClicked() {
        changeDate(numberOfDates: 7)
    }
    
    func didPreviousClicked() {
        changeDate(numberOfDates: -7)

    }
    
    private func changeDate(numberOfDates: Int) {
        if  let startDate = startDate,
            let endDate = endDate,
            let newStartDate = startDate.dateFrom(numberOfDays: numberOfDates),
            let newEndDate = endDate.dateFrom(numberOfDays: numberOfDates){
            
            didSelectNewDate(newStartDate, newEndDate)
        }
    }
    
    func didSelectNewDate(_ startDate: Date, _ endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
        
        let startDateFormat = startDate.formatDate(pattner: "dd MMMM")
        let endDateFormat = endDate.formatDate(pattner: "dd MMMM")
        let monthAndYear = startDate.formatDate(pattner: "MMMM yyyy")
        
        self.view?.formatDates(startDateFormat, endDateFormat, monthAndYear)
        self.view?.showActivityIndicator()
        self.fetchMoviesFromCurrentWeek(startDate: startDate, endDate: endDate)
    }
}

// MARK: WeekInteractorOutputInterface

extension WeekPresenter: WeekInteractorOutputInterface {
    
    func moviesFromCurrentWeekDidFetch(_ movies: [Movie]) {
        self.movies = movies
        
        self.view?.showMovies(movies)
        self.view?.hideActivityIndicator()
    }
    
    func moviesFromCurrentWeekDidError(_ error: DefaultError) {
        self.view?.onError(message: error.message)
    }
}
