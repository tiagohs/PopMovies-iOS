//
//  BaseViewController.swift
//  popmovies
//
//  Created by Tiago Silva on 26/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    func setupScreenTableView(tableView: UITableView) {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 690
    }
    
    func createNavigationBarButton(systemIcon: UIBarButtonItem.SystemItem, action: Selector?) -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: systemIcon, target: self, action: #selector(HomeController.didSearchButtonTaped))
    }
    
    func createNavigationBarButton(buttonBaseSize: Int, rounded: Bool, iconName: String, iconColor: UIColor?, action: Selector?) -> UIBarButtonItem {
        let nav = self.navigationController?.navigationBar
        var buttonSize = CGFloat(buttonBaseSize)
        
        if let navHeight = nav?.frame.size.height {
            buttonSize = navHeight - CGFloat(10.0)
        }
        
        let customUIButton = UIButton(type: .custom)
        customUIButton.frame = CGRect(x: 0.0, y: 0.0, width: buttonSize, height: buttonSize)
        
        
        var image = UIImage(named: iconName)
        
        if (iconColor != nil) {
            image = image?.overlayImage(color: iconColor ?? UIColor.white)
        }
        
        customUIButton.setImage(image, for: .normal)
        customUIButton.layer.masksToBounds = true
        
        if (rounded) {
            customUIButton.layer.cornerRadius = customUIButton.frame.size.height / 2
        }
    
        let customNavigationButtonItem = UIBarButtonItem(customView: customUIButton)
        let currWidth = customNavigationButtonItem.customView?.widthAnchor.constraint(equalToConstant: buttonSize)
        currWidth?.isActive = true
        let currHeight = customNavigationButtonItem.customView?.heightAnchor.constraint(equalToConstant: buttonSize)
        
        currHeight?.isActive = true
        customNavigationButtonItem.action = action
        customNavigationButtonItem.target = self
        
        return customNavigationButtonItem
    }
    
    func addRightButtonsToNavigationBar(buttons: [UIBarButtonItem]) {
        navigationItem.rightBarButtonItems = buttons
    }
    
    func addLeftButtonsToNavigationBar(buttons: [UIBarButtonItem]) {
        navigationItem.leftBarButtonItems = buttons
    }
}
