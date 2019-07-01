//
//  GenresController.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

// MARK: GenreListController: BaseViewController

class GenreListController: BaseViewController {
    // MARK: Constants
    
    let GenreCell                               = R.nib.genreCell.name
    let GenreCellIdentifier                     = "GenreCellIdentifier"
    
    // MARK: Outlets
    
    @IBOutlet weak var genresCollectionView: UICollectionView!
    
    // MARK: Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var presenter: GenreListPresenterInterface?
    
    var genres: [Genre]                         = []
    lazy var cellSize: CGSize                   = CGSize(width: self.view.bounds.width, height: CGFloat(250))
}

// MARK: Lifecycle Methods

extension GenreListController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter?.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter?.viewDidDisappear(animated)
    }
    
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension GenreListController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCellIdentifier, for: indexPath) as? GenreCell else {
            return UICollectionViewCell()
        }
        let genre = genres[indexPath.row]
        
        cell.genre = genre
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genre = genres[indexPath.row]
        
        presenter?.didSelectGenre(genre)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension GenreListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
}

// MARK: GenresViewInterface

extension GenreListController: GenreListViewInterface {
    
    func showGenres(with genres: [Genre]) {
        self.genres = genres
        
        self.genresCollectionView.reloadData()
    }
    
}

// MARK: GenresViewInterface - Setup Methods

extension GenreListController {
    
    func setupUI() {
        genresCollectionView.configureNibs(nibName: GenreCell, identifier: GenreCellIdentifier)
    }
}

// MARK: HeroViewControllerDelegate

extension GenreListController: HeroViewControllerDelegate {
    
    func heroWillStartAnimatingFrom(viewController: UIViewController) {
        genresCollectionView.hero.modifiers = [.cascade, .delay(0.8)]
    }
}
