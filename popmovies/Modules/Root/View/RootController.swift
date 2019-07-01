//
//  PopMoviesTabBarController.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

typealias RootTabs = (
    home: UIViewController,
    week: UIViewController,
    genre: UIViewController,
    profile: UIViewController
)

class RootController: UITabBarController, RootViewInterface {
    
    var presenter: RootPresenterInterface?
    
    init(tabs: RootTabs) {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [
            tabs.home,
            tabs.week,
            tabs.genre,
            tabs.profile
        ]
        
        self.hero.isEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension RootController {
    
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

extension RootController {
    
    func setupUI() {
        
    }
}
