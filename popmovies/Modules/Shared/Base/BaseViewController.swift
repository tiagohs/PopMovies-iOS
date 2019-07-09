//
//  BaseViewController.swift
//  popmovies
//
//  Created by Tiago Silva on 26/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: BaseViewController

class BaseViewController: UIViewController {
    
    var activityIndicatorContainer: UIView!
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.hero.isEnabled = true
    }
    
    func hideNavigationBar(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showNavigationBar(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupScreenTableView(tableView: UITableView) {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 690
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
        activityIndicator?.stopAnimating()
        activityIndicatorContainer?.removeFromSuperview()
        
        activityIndicator = nil
        activityIndicatorContainer = nil
    }
    
    func createDefaultActivityIndicator(autoStart: Bool = true) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.white)
        activityIndicator.color = UIColor.init(white: 160.0 / 255.0, alpha: 1.0)
        
        if autoStart {
            activityIndicator.startAnimating()
        }
        
        return activityIndicator
    }
}
