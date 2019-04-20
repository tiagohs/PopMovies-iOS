//
//  MovieDetailsController.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailsController: UIViewController {
    
    let movieDetailsHeaderCellIdentifier = "MovieDetailsHeaderCellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    
    var movie: Movie? = nil
    var presenter: IMovieDetailsPresenter? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.clear
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.barStyle = .default
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MovieDetailsPresenter(view: self)
        presenter?.fetchMovieDetails(movieId: movie?.id)
    }
}

extension MovieDetailsController: IMovieDetailsView {
    
    func bindMovie(movie: Movie) {
        self.movie = movie
        
        self.tableView.reloadData()
    }
    
}

extension MovieDetailsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: movieDetailsHeaderCellIdentifier, for: indexPath) as! MovieDetailsHeaderCell
            
            cell.movie = self.movie
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}


