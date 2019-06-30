//
//  GenresController.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

class GenresController: BaseViewController {
    let GenreCellIdentifier                     = "GenreCellIdentifier"
    
    let GenreShowMovieListSegueIdentifier       = "GenreShowMovieListSegueIdentifier"
    
    @IBOutlet weak var genresCollectionView: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var presenter: IGenresPresenter!
    
    var genres: [Genre] = []
    lazy var cellSize: CGSize = CGSize(width: self.view.bounds.width, height: CGFloat(250))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNibs(collection: genresCollectionView, nibName: "GenreCell", identifier: GenreCellIdentifier)
        
        self.presenter = GenresPresenter(view: self)
        self.presenter.fetchGenres()
    }
}

extension GenresController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        
        performSegue(withIdentifier: GenreShowMovieListSegueIdentifier, sender: genre)
    }
    
}

extension GenresController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
}

// MARK: Prepare Segues

extension GenresController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        MovieListController.prepareMoviesByGenreList(segue: segue, sender: sender)
    }
    
}
extension GenresController: IGenresView {
    
    func bindgenres(genres: [Genre]) {
        self.genres = genres
        
        self.genresCollectionView.reloadData()
    }
    
}

extension GenresController: HeroViewControllerDelegate {
    
    func heroWillStartAnimatingFrom(viewController: UIViewController) {
        genresCollectionView.hero.modifiers = [.cascade, .delay(0.8)]
    }
}
