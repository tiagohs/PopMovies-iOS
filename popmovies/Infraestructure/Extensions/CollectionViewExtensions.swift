//
//  CollectionViewExtensions.swift
//  popmovies
//
//  Created by Tiago Silva on 29/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func configureNibs(nibName: String, identifier: String) {
        let cellNib = UINib(nibName: nibName, bundle: nil)
        
        register(cellNib, forCellWithReuseIdentifier: identifier)
        reloadData()
    }
}
