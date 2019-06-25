//
//  BaseViewController.swift
//  popmovies
//
//  Created by Tiago Silva on 26/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var activityIndicatorContainer: UIView!
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.hero.isEnabled = true
    }
    
    func setupScreenTableView(tableView: UITableView) {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 690
    }
    
    func configureNibs(collection: UICollectionView, nibName: String, identifier: String) {
        let cellNib = UINib(nibName: nibName, bundle: nil)
        
        collection.register(cellNib, forCellWithReuseIdentifier: identifier)
        collection.reloadData()
    }
    
    
    func onError(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func showActivityIndicator() {
        if activityIndicator != nil && activityIndicatorContainer != nil {
            hideActivityIndicator()
        }
        
        activityIndicatorContainer = UIView()
        
        activityIndicatorContainer.frame = view.frame
        activityIndicatorContainer.center = view.center
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = ViewUtils.UIColorFromHEX(hex: "#444444").withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        activityIndicatorContainer.addSubview(loadingView)
        view.addSubview(activityIndicatorContainer)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicatorContainer.removeFromSuperview()
        
        activityIndicator = nil
        activityIndicatorContainer = nil
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
