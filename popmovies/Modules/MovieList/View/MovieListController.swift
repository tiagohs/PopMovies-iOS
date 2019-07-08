//
//  MovieListController.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

// MARK: MovieListController: BaseViewController

class MovieListController: BaseViewController {
    // MARK: Constants
    
    let MovieCellIdentifier                     = "MovieCellIdentifier"
    let MovieCellName                           = R.nib.movieCell.name
    
    let numberOfCollunms = 2
    
    // MARK: Outlets
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    // MARK: Properties
    
    var movies: [Movie]?
    var presenter: MovieListPresenterInterface?
    
    var infiniteScrollView: UIScrollView?
    
    lazy var cellSize: CGSize = CGSize(width: self.moviesCollectionView.bounds.width / CGFloat(self.numberOfCollunms), height: (self.moviesCollectionView.bounds.width / CGFloat(self.numberOfCollunms)) + CGFloat(115))
    
}

// MARK: Lifecycle Methods

extension MovieListController {
    
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

extension MovieListController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCellIdentifier, for: indexPath) as? MovieCell, let movies = self.movies else {
            return UICollectionViewCell()
        }
        let movie = movies[indexPath.row]
        
        cell.bindMovieCellDefault(movie: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movies = self.movies else {
            return
        }
        let movie = movies[indexPath.row]
        
        presenter?.didSelectMovie(movie)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension MovieListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
}

// MARK: MovieListViewInterface

extension MovieListController: MovieListViewInterface {
    
    func showMovies(with movies: [Movie]) {
        self.movies = movies
        
        moviesCollectionView.reloadData()
        
        stopInfiniteScroll()
    }
    
    func stopInfiniteScroll() {
        self.moviesCollectionView.finishInfiniteScroll()
    }
}

// MARK: MovieListViewInterface - Setup Methods

extension MovieListController {
    
    func setupUI() {
        let activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.white)
        activityIndicator.color = UIColor.init(white: 160.0 / 255.0, alpha: 1.0)
        activityIndicator.startAnimating()
        
        moviesCollectionView.configureNibs(nibName: MovieCellName, identifier: MovieCellIdentifier)
        
        moviesCollectionView.infiniteScrollIndicatorView = activityIndicator
        moviesCollectionView.infiniteScrollIndicatorMargin = 20
        moviesCollectionView.addInfiniteScroll { (scrollView) in
            self.infiniteScrollView = scrollView
            
            self.presenter?.fetchMovies()
        }
        
    }
}
