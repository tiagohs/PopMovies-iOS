//
//  BaseContract.swift
//  popmovies
//
//  Created by Tiago Silva on 11/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewInterface {
    
    func setupUI()
    func hideNavigationBar(_ animated: Bool)
    func showNavigationBar(_ animated: Bool)
    func setupScreenTableView(tableView: UITableView)
    func onError(message: String)
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol BasePresenterInterface {
    
    func viewDidLoad()
    func viewDidDisappear(_ animated: Bool)
    func viewWillAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
}

protocol BaseInteractorInterface {
    
    func outputDidLoad()
    func outputFinished()
}

protocol BaseWireframeInterface {
    
}
