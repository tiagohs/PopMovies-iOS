//
//  AppDelegate.swift
//  popmovies
//
//  Created by Tiago Silva on 10/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        setupStatusBar()
        setupApp()
        
        UITabBar.appearance().tintColor = ViewUtils.UIColorFromHEX(hex: Constants.COLOR.colorPrimary)
        UITabBar.appearance().backgroundColor = UIColor.white
        
        return true
    }

    private func setupStatusBar() {
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.clear
    }
    
    private func setupApp() {
        let submodules = (
            home: HomeWireframe.buildModuleFromUINavigation(),
            week: WeekWireframe.buildModuleFromUINavigation(),
            genre: GenreListWireframe.buildModuleFromUINavigation(),
            profile: ProfileWireframe.buildModuleFromUINavigation()
        )
        let rootController = RootWireframe.buildModule(with: submodules)
        
        self.window?.rootViewController = rootController
        self.window?.makeKeyAndVisible()
    }
    
    
}

