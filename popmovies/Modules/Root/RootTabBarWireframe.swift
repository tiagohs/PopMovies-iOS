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
    
    static func buildTabs() -> [UIViewController] {
        let home = buildTabBarItem(
                        controller: HomeWireframe.buildModuleFromUINavigation(),
                        title: "Home",
                        image: R.image.homeIcon(),
                        tag: 0 )
        let week = buildTabBarItem(
                        controller: WeekWireframe.buildModuleFromUINavigation(),
                        title: "Week",
                        image: R.image.calendarIcon(),
                        tag: 1 )
        let genre = buildTabBarItem(
                        controller: GenreListWireframe.buildModuleFromUINavigation(),
                        title: "Genre",
                        image: R.image.genreIcon(),
                        tag: 2 )
        let profile = buildTabBarItem(
                        controller: ProfileWireframe.buildModuleFromUINavigation(),
                        title: "Profile",
                        image: R.image.personIcon(),
                        tag: 3 )
        
        return [ home, week, genre, profile ]
    }
    
    private static func buildTabBarItem(controller: UIViewController, title: String, image: UIImage?, tag: Int) -> UIViewController {
        
        controller.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        
        return controller
    }
}
