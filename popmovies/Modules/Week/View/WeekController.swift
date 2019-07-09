//
//  WeekController.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import FSCalendar

// MARK: WeekController: BaseViewController

class WeekController: BaseViewController {
    // MARK: Constants
    
    let MovieDetailsCell                    = R.nib.movieDetailsCellCollectionView.name
    let MovieDetailsCellIdentifier          = "MovieDetailsCellIdentifier"
    
    // MARK: Properties
    
    @IBOutlet weak var selectMonthAndYearLabel: UILabel!
    @IBOutlet weak var selectDaysLabel: UILabel!
    
    @IBOutlet weak var weekMoviesCollectionView: UICollectionView!
    @IBOutlet weak var weekMoviesCollectionViewViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            //weekMoviesCollectionViewViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    // MARK: Properties
    
    var presenter: WeekPresenterInterface?
    
    var movies: [Movie] = []
    lazy var cellSize: CGSize                   = CGSize(width: self.view.bounds.width, height: CGFloat(209))
}

// MARK: Life Cycle methods

extension WeekController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.presenter?.viewDidDisappear(animated)
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension WeekController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailsCellIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movie = movies[indexPath.row]
        
        cell.movie = movie
        cell.bindMovieCellDetails(movie: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        presenter?.didSelectMovie(movie)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension WeekController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
}

// MARK: CalendarDelegate

extension WeekController: CalendarDelegate {
    
    func didSelectNewDate(_ startDate: Date, _ endDate: Date) {
        presenter?.didSelectNewDate(startDate, endDate)
    }
    
    func formatDates(_ startDateFormat: String, _ endDateFormat: String, _ monthAndYear : String) {
        selectMonthAndYearLabel.text = monthAndYear
        selectDaysLabel.text = "\(startDateFormat) - \(endDateFormat)"
    }
}

// MARK: WeekViewInterface

extension WeekController: WeekViewInterface {
    
    func showMovies(_ movies: [Movie]) {
        self.movies = movies
        
        weekMoviesCollectionView.reloadData()
    }
    
}

// MARK: WeekViewInterface - Setup methods

extension WeekController {
    
    func setupUI() {
        weekMoviesCollectionView.configureNibs(nibName: MovieDetailsCell, identifier: MovieDetailsCellIdentifier)
    }
    
}



// MARK: Action Methods

private extension WeekController {
    
    @IBAction func didSelectDateFromCalendarClicked(_ sender: Any) {
        presenter?.didSelectDateFromCalendarClicked()
    }
    
    @IBAction func didNextClicked(_ sender: Any) {
        presenter?.didNextClicked()
    }
    
    @IBAction func didPreviousClicked(_ sender: Any) {
        presenter?.didPreviousClicked()
    }
}
