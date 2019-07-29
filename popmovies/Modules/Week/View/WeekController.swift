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
    
    let MovieDetailsCell                        = R.nib.movieDetailsCellCollectionView.name
    let MovieDetailsCellIdentifier              = "MovieDetailsCellIdentifier"
    
    // MARK: Properties
    
    @IBOutlet weak var selectMonthAndYearLabel: UILabel!
    @IBOutlet weak var selectDaysLabel: UILabel!
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var pickerContainer: UIView!
    
    @IBOutlet weak var weekMoviesCollectionView: UICollectionView!
    
    // MARK: Properties
    
    var presenter: WeekPresenterInterface?
    
    var countries = Locale.getListOfCountries()
    var movies: [Movie]                         = []
    lazy var cellSize: CGSize                   = CGSize(width: self.view.bounds.width, height: CGFloat(209))
    let backgroundView: UIView = UIView()
    var showPicker = false
    
    var selectedLocale: LocaleDTO?
    
    var startDate: Date?
    var endDate: Date?
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

extension WeekController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row].displayName.capitalized
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedLocale = self.countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.view.bounds.width
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60.0
    }
    
}

// MARK: CalendarDelegate

extension WeekController: CalendarDelegate {
    
    func didSelectNewDate(_ startDate: Date, _ endDate: Date) {
        presenter?.didSelectNewDate(startDate, endDate, self.selectedLocale)
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
    
    func updateDates(_ startDate: Date, _ endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }
}

// MARK: WeekViewInterface - Setup methods

extension WeekController {
    
    func setupUI() {
        weekMoviesCollectionView.configureNibs(nibName: MovieDetailsCell, identifier: MovieDetailsCellIdentifier)
        
        self.backgroundView.frame = view.frame
        self.backgroundView.center = view.center
        self.backgroundView.backgroundColor = R.color.activityIndicatorBackgroundColor()
        self.backgroundView.isHidden = true
        
        self.countryPicker.showsSelectionIndicator = true
        
        view.addSubview(self.backgroundView)
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
    
    @IBAction func didChangeCountryClicked(_ sender: Any) {
        self.update()
    }
    
    @IBAction func didTapDone() {
        if let locale = selectedLocale,
            let startDate = self.startDate,
            let endDate = self.endDate  {
            self.presenter?.didSelectNewDate(startDate, endDate, locale)
            self.update()
        }
    }
    
    @IBAction func didTapCancel() {
        self.selectedLocale = nil
        self.update()
    }
    
    private func update() {
        self.showPicker = !showPicker
        
        self.updateBackground(showPicker)
        
        view.bringSubviewToFront(self.pickerContainer)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerContainer.alpha = self.showPicker ? 1 : 0
        })
    }
    
    private func updateBackground(_ show: Bool) {
        self.backgroundView.isHidden = !show
    }
}
