//
//  TableViewExtensions.swift
//  popmovies
//
//  Created by Tiago Silva on 07/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

extension UITableView {
    
    func configureNibs(nibName: String, identifier: String) {
        let cellNib = UINib(nibName: nibName, bundle: nil)
        
        register(cellNib, forCellReuseIdentifier: identifier)
        //reloadData()
    }
}
