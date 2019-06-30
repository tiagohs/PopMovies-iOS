//
//  PersonDetailsController.swift
//  popmovies
//
//  Created by Tiago Silva on 19/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

class PersonDetailsController: BaseViewController {
    // MARK: Constants

    let MovieDetailsControllerIdentifier            = "MovieDetailsController"
    let ImageListControllerIdentifier               = "ImageListControllerIdentifier"
    let ImageViewerControllerIdentifier             = "ImageViewerControllerIdentifier"
    let PersonDetailsToMovieListIdentifier          = "PersonDetailsToMovieListIdentifier"

    let PersonDetailsHeaderCellIdentifier           = "PersonDetailsHeaderCellIdentifier"
    let PersonDetailsOverviewCellIdentifier         = "PersonDetailsOverviewCellIdentifier"
    let PersonDetailsKnownForCellIdentifier         = "PersonDetailsKnownForCellIdentifier"
    let PersonDetailsFilmographyCellIdentifier      = "PersonDetailsFilmographyCellIdentifier"
    
    let numberOfRows                                = 4
    
    // MARK: Outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    // MARK: Properties

    var isFromServer = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
    
    var style:UIStatusBarStyle = .lightContent
    
    var presenter: IPersonDetailsPresenter!
    var person: Person?
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupPresenters()
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
        
        backButton.backgroundColor = color
        backButton.imageView?.setImageColorBy(uiColor: imageColor)
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

// MARK: UITableViewDelegate, UITableViewDataSource

extension PersonDetailsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return setupHeaderCell(tableView, indexPath)
        case 1:
            return setupOverviewCell(tableView, indexPath)
        case 2:
            return setupKnownFor(tableView, indexPath)
        case 3:
            return setupFilmographyCell(tableView, indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    private func setupHeaderCell(_ tableView: UITableView,_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonDetailsHeaderCellIdentifier, for: indexPath) as? PersonDetailsHeaderCell else {
            return UITableViewCell()
        }
        
        if person != nil {
            cell.person = person
            
            if (isFromServer) {
                cell.bindBackdropImage(person!)
            }
        }
        
        return cell
    }
    
    private func setupOverviewCell(_ tableView: UITableView,_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonDetailsOverviewCellIdentifier, for: indexPath) as? PersonDetailsOverviewCell else {
            return UITableViewCell()
        }
        
        if person != nil { cell.person = person }
        
        return cell
    }
    
    private func setupKnownFor(_ tableView: UITableView,_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonDetailsKnownForCellIdentifier, for: indexPath) as? PersonDetailsKnownForCell else {
            return UITableViewCell()
        }
        
        if person != nil { cell.person = person }
        if cell.knownForListener == nil {
            cell.knownForListener = self
        }
        
        return cell
    }
    
    private func setupFilmographyCell(_ tableView: UITableView,_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonDetailsFilmographyCellIdentifier, for: indexPath) as? PersonDetailsFilmographyCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

// MARK: IPersonDetailsView

extension PersonDetailsController: IPersonDetailsView {
    
    func bindPerson(person: Person) {
        self.person = person
        
        isFromServer = true
        
        self.tableView.reloadData()
    }
    
}

// MARK: IKnownForListener

extension PersonDetailsController: IKnownForListener {
    
    func didMovieSelect(_ movie: Movie) {
        MovieDetailsController.presentMovieDetailsController(from: self, movie)
    }
    
    func didImageSelect(_ image: Image, allImages: [Image], indexPath: IndexPath) {
        guard let controller = self.storyboard!.instantiateViewController(withIdentifier: ImageViewerControllerIdentifier) as? ImageViewerController else {
            return
        }
        
        controller.hero.modalAnimationType = .fade
        controller.selectedIndex = indexPath
        controller.image = image
        controller.allImages = allImages
        controller.person = self.person
        
        self.present(controller, animated: true, completion: nil)
    }
    
    private func seeAllImages(_ allImages: [Image]) {
        guard let controller = self.storyboard!.instantiateViewController(withIdentifier: ImageListControllerIdentifier) as? ImageListController else {
            return
        }
        
        controller.hero.modalAnimationType = .fade
        controller.allImages = allImages
        controller.person = self.person
        
        self.present(controller, animated: true, completion: nil)
    }
}

// MARK: Prepare Methods

extension PersonDetailsController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case PersonDetailsToMovieListIdentifier:
            return MovieListController.prepareMoviesByMovieListToUINavigation(segue: segue, sender: sender, title: self.person?.name)
        default:
            return
        }
    }
    
}

// MARK: Setup Methods

private extension PersonDetailsController {
    
    func setupUI() {
        setupScreenTableView(tableView: tableView)
        
        backButton.layer.cornerRadius = backButton.bounds.width / 2
        shareButton.layer.cornerRadius = backButton.bounds.width / 2
        
        tableView.reloadData()
    }
    
    func setupPresenters() {
        presenter = PersonDetailsPresenter(view: self)
        presenter.fetchPersonDetails(personId: person?.id)
    }
}

// MARK: Actions Methods

private extension PersonDetailsController {
    
    @IBAction func dismiss() {
        hero.dismissViewController()
    }
    
    @IBAction func didSeeAllImagesClicked(_ sender: Any) {
        guard let allImages = self.person?.allImages, !allImages.isEmpty else {
            return
        }
        
        seeAllImages(allImages)
    }
    
    @IBAction func didSeeAllMoviesClicked(_ sender: Any) {
        guard let allMovies = self.person?.allMovieCredits, !allMovies.isEmpty else {
            return
        }
        
        performSegue(withIdentifier: PersonDetailsToMovieListIdentifier, sender: allMovies)
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
    
}
