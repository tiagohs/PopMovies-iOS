//
//  HomeController.swift
//  popmovies
//
//  Created by Tiago Silva on 10/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class HomeController: UIViewController, IHomeView {
    
    var homePresenter: IHomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePresenter = HomePresenter(view: self)
        
        homePresenter?.fetchPopularMovies()
    }
    

}
