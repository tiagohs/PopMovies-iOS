//
//  TabBarViewController.swift
//  popmovies
//
//  Created by Tiago Silva on 22/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundColor = UIColor.white
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.barStyle = .blackOpaque
        self.tabBar.tintColor = ViewUtils.UIColorFromHEX(hex: Constants.Color.colorAccent)
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0);
        self.tabBar.layer.shadowRadius = 5;
        self.tabBar.layer.shadowColor = UIColor.black.cgColor;
        self.tabBar.layer.shadowOpacity = 0.2;
    }
    
}
