//
//  MovieDetailsController.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit
import Hero

// MARK: MovieDetailsController: BaseViewController

class MovieDetailsController: BaseViewController {
    let MovieDetailsToMovieListSegueIdentifier      = "MovieDetailsToMovieListSegueIdentifier"
    
    let PersonDetailsIdentifier                     = "PersonDetailsIdentifier"
    let MovieDetailsControllerIdentifier            = "MovieDetailsControllerIdentifier"
    let ImageViewerControllerIdentifier             = "ImageViewerControllerIdentifier"
    let VideoViewerControllerIdentifier             = "VideoViewerControllerIdentifier"
    let ImageListControllerIdentifier               = "ImageListControllerIdentifier"
    let VideoListControllerIdentifier               = "VideoListControllerIdentifier"
    
    let MovieDetailsHeaderCellIdentifier        = "MovieDetailsHeaderCellIdentifier"
    let MovieDetailsOverviewIdentifier          = "MovieDetailsOverviewIdentifier"
    let MovieDetailsCreditsCellIdentifier       = "MovieDetailsCreditsCellIdentifier"
    let MovieDetailsMidiaCellIdentifier         = "MovieDetailsMidiaCellIdentifier"
    let MovieDetailsRelatedCellIdentifier       = "MovieDetailsRelatedCellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var panGesture: UIPanGestureRecognizer!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var style:UIStatusBarStyle = .lightContent
    var isTabMidiaConfigured = false
    
    var movie: Movie? = nil
    var movieRankings: MovieOMDB? = nil
    
    var presenter: IMovieDetailsPresenter? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        setupScreenTableView(tableView: tableView)
        //setupMovieDetailsNavigationBar()
        
        closeButton.layer.cornerRadius = closeButton.bounds.width / 2
        shareButton.layer.cornerRadius = shareButton.bounds.width / 2
        
        super.viewWillAppear(animated)
    }
    
    private func setupMovieDetailsNavigationBar() {
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        
//        let shareIcon = createNavigationBarButton(
//            buttonBaseSize: 20,
//            rounded: false,
//            iconName: Constants.IMAGES.ICON_SHARE,
//            iconColor: UIColor.white,
//            action: #selector(MovieDetailsController.didShareButtonTaped)
//        )
//
//        addRightButtonsToNavigationBar(buttons: [shareIcon])
    }
    
    @objc func didShareButtonTaped() {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        self.navigationController?.navigationBar.barStyle = .default
//        self.navigationController?.navigationBar.tintColor = ViewUtils.UIColorFromHEX(hex: Constants.COLOR.colorPrimary)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MovieDetailsPresenter(view: self)
        presenter?.fetchMovieDetails(movie: movie)
        
        self.title = movie?.title
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 155
        
        if offset > 1 {
            offset = 1
            
            updateStatusBarStyle(offset: offset, barStyle: .default)
        } else {
            updateStatusBarStyle(offset: offset, barStyle: .black)
        }
    }
    
    private func updateStatusBarStyle(offset: CGFloat, barStyle: UIBarStyle) {
        let color = UIColor(white: 1.0 - offset, alpha: 1.0)
        let imageColor = UIColor(white: offset, alpha: 1.0)
        
        closeButton.backgroundColor = color
        closeButton.imageView?.setImageColorBy(uiColor: imageColor)
        
        shareButton.backgroundColor = color
        shareButton.imageView?.setImageColorBy(uiColor: imageColor)
        
        if (offset > 0.3) {
            self.style = .default
        } else {
            self.style = .lightContent
        }
        
        setNeedsStatusBarAppearanceUpdate()
    }
}

extension MovieDetailsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsHeaderCellIdentifier, for: indexPath) as! MovieDetailsHeaderCell
            
            if (self.movie != nil) { cell.movie = self.movie }
            if (self.movieRankings != nil) { cell.movieRanking = self.movieRankings }
            if (cell.movieDetailsHeaderListener == nil) { cell.movieDetailsHeaderListener = self }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsOverviewIdentifier, for: indexPath) as? MovieDetailsOverviewCell else {
                return UITableViewCell()
            }
            
            if (self.movie != nil) { cell.movie = self.movie }
            if (self.movieRankings != nil) { cell.movieRanking = self.movieRankings }
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsCreditsCellIdentifier, for: indexPath) as? MovieDetailsCreditsCell else {
                return UITableViewCell()
            }
            
            if (self.movie != nil) { cell.movie = self.movie }
            if (cell.personListener == nil) {
                cell.personListener = self
            }
            
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsMidiaCellIdentifier, for: indexPath) as? MovieDetailsMidiaCell else {
                return UITableViewCell()
            }
            
            if (self.movie != nil) { cell.movie = self.movie }
            if (cell.midiaListener == nil) { cell.midiaListener = self }
            
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsRelatedCellIdentifier, for: indexPath) as? MovieDetailsRelatedCell else {
                return UITableViewCell()
            }
            
            if (self.movie != nil) { cell.movie = self.movie }
            if (self.movieRankings != nil) { cell.movieRanking = self.movieRankings }
            if (cell.relatedMoviesListener == nil) {
                cell.relatedMoviesListener = self
            }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let progress = translation.y / 2 / view.bounds.height
        
        switch sender.state {
        case .began:
            dismiss()
        case .changed:
            Hero.shared.update(progress)
            
            let currentPos = CGPoint(x: translation.x + view.center.x, y: translation.y + view.center.y)
            
            Hero.shared.apply(modifiers: [.position(currentPos)], to: view)
        default:
            if progress + sender.velocity(in: nil).y / view.bounds.height > 0.2 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    
    @IBAction func dismiss() {
        hero.dismissViewController()
    }
}

extension MovieDetailsController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (sender as? Movie) != nil {
            MovieListController.prepareSimilarMoviesList(segue: segue, sender: sender)
            return
        }
        
        if (sender as? Genre) != nil {
            MovieListController.prepareMoviesByGenreListToUINavigation(segue: segue, sender: sender)
            return
        }
        
    }
}

extension MovieDetailsController: IMovieDetailsView {
    
    func bindMovie(movie: Movie) {
        self.movie?.credits = movie.credits
        self.movie?.keywords = movie.keywords
        self.movie?.runtime = movie.runtime
        self.movie?.videos = movie.videos
        self.movie?.images = movie.images
        self.movie?.homepage = movie.homepage
        self.movie?.productionCompanies = movie.productionCompanies
        self.movie?.productionCountries = movie.productionCountries
        self.movie?.similiarMovies = movie.similiarMovies
        self.movie?.genres = movie.genres
        
        self.tableView.reloadData()
    }
    
    func bindMovieRankings(movie: MovieOMDB) {
        self.movieRankings = movie
        
        let headerIndex = IndexPath(item: 0, section: 0)
        let middleIndex = IndexPath(item: 1, section: 0)
        
        self.tableView.reloadRows(at: [headerIndex, middleIndex], with: .none)
    }
    
    func bindMovieImages(images: Images) {
//        self.movie?.images = images
//        
//        let index = IndexPath(item: 1, section: 0)
//        
//        self.tableView.reloadRows(at: [index], with: .none)
    }
    
}

extension MovieDetailsController: TabBarCallback {
    
    func onTabBarSelect(index: Int) {
        if index == 0 && isTabMidiaConfigured { return }
        
        isTabMidiaConfigured = true
    }
    
}

extension MovieDetailsController:
        IPersonListener,
        IRelatedMoviesListener,
        IMidiaListener,
        IMovieDetailsHeaderListener {
    
    func didPersonSelect(_ person: Person) {
        if let controller = self.storyboard!.instantiateViewController(withIdentifier: PersonDetailsIdentifier) as? PersonDetailsController {
            
            controller.hero.modalAnimationType = .slide(direction: .left)
            controller.person = person
            
            self.show(controller, sender: nil)
        }
    }
    
    func didMovieSelect(_ movie: Movie) {
        if let controller = self.storyboard!.instantiateViewController(withIdentifier: MovieDetailsControllerIdentifier) as? MovieDetailsController {
            
            controller.hero.modalAnimationType = .slide(direction: .up)
            controller.movie = movie
            
            self.show(controller, sender: nil)
        }
    }
    
    func didSeeAllRelatedMoviesClicked() {
        performSegue(withIdentifier: MovieDetailsToMovieListSegueIdentifier, sender: self.movie)
    }
    
    func didImageSelected(_ image: Image, _ allImages: [Image], indexPath: IndexPath) {
        if let controller = self.storyboard!.instantiateViewController(withIdentifier: ImageViewerControllerIdentifier) as? ImageViewerController {
            
            controller.hero.modalAnimationType = .fade
            controller.selectedIndex = indexPath
            controller.image = image
            controller.allImages = allImages
            controller.movie = self.movie
            
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func didVideoSelected(_ video: Video, _ allVideos: [Video]) {
        if let controller = self.storyboard!.instantiateViewController(withIdentifier: VideoViewerControllerIdentifier) as? VideoViewerController {
            
            controller.hero.modalAnimationType = .fade
            controller.video = video
            
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func didSeeAllVideosClicked(_ allVideos: [Video]) {
        guard let controller = self.storyboard!.instantiateViewController(withIdentifier: VideoListControllerIdentifier) as? VideoListController else {
            return
        }
        
        controller.hero.modalAnimationType = .fade
        controller.allVideos = allVideos
        
        self.present(controller, animated: true, completion: nil)
    }
    
    func didSeeAllWallpapersClicked(_ allImages: [Image]) {
        guard let controller = self.storyboard!.instantiateViewController(withIdentifier: ImageListControllerIdentifier) as? ImageListController else {
            return
        }
        
        controller.hero.modalAnimationType = .fade
        controller.allImages = allImages
        controller.movie = self.movie
        
        self.present(controller, animated: true, completion: nil)
    }
    
    func didGenreSelected(_ genre: Genre) {
        performSegue(withIdentifier: MovieDetailsToMovieListSegueIdentifier, sender: genre)
    }
    
}

extension MovieDetailsController {
    
    static func prepareMovieDetailsController(_ segue: UIStoryboardSegue,_ sender: Any?) {
        guard let movieDetailsController = segue.destination as? MovieDetailsController, let movie = sender as? Movie else {
            return
        }
        
        movieDetailsController.movie = movie
    }
}

