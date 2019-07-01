//
//  RootTabBarWireframe.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

typealias Submodules = (
    home: UIViewController,
    week: UIViewController,
    genre: UIViewController,
    profile: UIViewController
)

class RootTabBarWireframe {
    
    static func buildTabs(with subModules: Submodules) -> RootTabs {
        let homeTabBarItem = UITabBarItem(title: "Home", image: R.image.homeIcon(), tag: 0)
        let weekTabBarItem = UITabBarItem(title: "Week", image: R.image.calendarIcon(), tag: 1)
        let searchTabBarItem = UITabBarItem(title: "Genre", image: R.image.genreIcon(), tag: 2)
        let profileTabBarItem = UITabBarItem(title: "Profile", image: R.image.personIcon(), tag: 3)
        
        subModules.home.tabBarItem = homeTabBarItem
        subModules.week.tabBarItem = weekTabBarItem
        subModules.genre.tabBarItem = searchTabBarItem
        subModules.profile.tabBarItem = profileTabBarItem
        
        return (
            home: subModules.home,
            week: subModules.week,
            genre: subModules.genre,
            profile: subModules.profile
        )
    }
}
