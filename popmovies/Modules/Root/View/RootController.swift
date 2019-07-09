//
//  PopMoviesTabBarController.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class RootController: UITabBarController, RootViewInterface {
    
    var presenter: RootPresenterInterface?
    
    init(tabs: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = tabs
        
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
