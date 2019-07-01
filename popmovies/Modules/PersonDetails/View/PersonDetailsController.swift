//
//  PersonDetailsController.swift
//  popmovies
//
//  Created by Tiago Silva on 19/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

// MARK: PersonDetailsController: BaseViewController

class PersonDetailsController: BaseViewController {
    // MARK: Constants

    let PersonDetailsHeaderCellIdentifier           = R.reuseIdentifier.personDetailsHeaderCellIdentifier.identifier
    let PersonDetailsOverviewCellIdentifier         = R.reuseIdentifier.personDetailsOverviewCellIdentifier.identifier
    let PersonDetailsKnownForCellIdentifier         = R.reuseIdentifier.personDetailsKnownForCellIdentifier.identifier
    let PersonDetailsFilmographyCellIdentifier      = R.reuseIdentifier.personDetailsFilmographyCellIdentifier.identifier
    
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
    
    var style: UIStatusBarStyle = .lightContent
    
    var presenter: PersonDetailsPresenterInterface?
    var person: Person?
}

// MARK: Lifecycle Methods

extension PersonDetailsController {
    
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
        if cell.personDetailsHeaderDelegate == nil {
            cell.personDetailsHeaderDelegate = self
        }
        
        return cell
    }
    
    private func setupOverviewCell(_ tableView: UITableView,_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonDetailsOverviewCellIdentifier, for: indexPath) as? PersonDetailsOverviewCell else {
            return UITableViewCell()
        }
        
        if person != nil { cell.person = person }
        if cell.personDetailsOverviewDelegate == nil {
            cell.personDetailsOverviewDelegate = self
        }
        
        return cell
    }
    
    private func setupKnownFor(_ tableView: UITableView,_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonDetailsKnownForCellIdentifier, for: indexPath) as? PersonDetailsKnownForCell else {
            return UITableViewCell()
        }
        
        if person != nil { cell.person = person }
        if cell.personDetailsKnownForDelegate == nil {
            cell.personDetailsKnownForDelegate = self
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

// MARK: PersonDetailsViewInterface

extension PersonDetailsController: PersonDetailsViewInterface {
    
    func showPerson(with person: Person) {
        self.person = person
        
        isFromServer = true
        
        self.tableView.reloadData()
    }
}

// MARK: PersonDetailsViewInterface - Setup Methods

extension PersonDetailsController {
    
    func setupUI() {
        setupScreenTableView(tableView: tableView)
        
        backButton.layer.cornerRadius = backButton.bounds.width / 2
        shareButton.layer.cornerRadius = backButton.bounds.width / 2
        
        tableView.reloadData()
    }
    
}

// MAR: PersonDetailsHeaderDelegate

extension PersonDetailsController: PersonDetailsHeaderDelegate {
    
    func didFacebookClicked() {
        guard let url = URLUtils.formatFacebookUrl(facebookId: person?.externalIds?.facebookId) else { return }
        
        presenter?.didLinkClicked(with: url)
    }
    
    func didTwitterClicked() {
        guard let url = URLUtils.formatTwitterUrl(twitterId: person?.externalIds?.twitterId) else { return }
        
        presenter?.didLinkClicked(with: url)
    }
    
    func didInstagramClicked() {
        guard let url = URLUtils.formatInstagramUrl(instagramId: person?.externalIds?.instagramId) else { return }
        
        presenter?.didLinkClicked(with: url)
    }
    
    
}

// MARK: PersonDetailsOverviewDelegate

extension PersonDetailsController: PersonDetailsOverviewDelegate {
    
    func didImdbLinkClicked() {
        guard let url = URLUtils.formartPersonIMDB(imdbId: person?.imdbId) else { return }
        
        presenter?.didLinkClicked(with: url)
    }
    
    func didWikiLinkClicked() {
        guard let url = URLUtils.formatWikiUrl(wikiSearchTerm: person?.name) else { return }
        
        presenter?.didLinkClicked(with: url)
    }
    
}

// MARK: PersonDetailsKnownForDelegate

extension PersonDetailsController: PersonDetailsKnownForDelegate {
    
    func didMovieSelect(_ movie: Movie) {
        presenter?.didSelectMovie(movie)
    }
    
    func didImageSelect(_ image: Image, indexPath: IndexPath) {
        presenter?.didImageSelect(image, indexPath: indexPath)
    }
}

// MARK: Actions Methods

private extension PersonDetailsController {
    
    @IBAction func dismiss() {
        hero.dismissViewController()
    }
    
    @IBAction func didSeeAllImagesClicked(_ sender: Any) {
        presenter?.didSeeAllImagesClicked()
    }
    
    @IBAction func didSeeAllMoviesClicked(_ sender: Any) {
        presenter?.didSeeAllMoviesClicked()
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
