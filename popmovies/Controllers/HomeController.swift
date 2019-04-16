//
//  HomeController.swift
//  popmovies
//
//  Created by Tiago Silva on 10/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class HomeController: UIViewController, IHomeView {
    
    let cellIdentifier = "CellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    
    var homePresenter: IHomePresenter?
    
    var featureMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePresenter = HomePresenter(view: self)
        
        homePresenter?.fetchPopularMovies()
    }
    
    func bindFeatureMovies(featureMovies: [Movie]) {
        self.featureMovies = featureMovies
        
        let indexPath = IndexPath(item: 0, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .left)
    }
}

extension HomeController:
    UITableViewDataSource,
    UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FeatureMoviesCell
            
            cell.updateFeatureMoviesCollection(featureMovies: featureMovies)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
