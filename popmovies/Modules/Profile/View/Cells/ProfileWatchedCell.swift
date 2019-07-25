//
//  ProfileWatchedCell.swift
//  popmovies
//
//  Created by Tiago Silva on 07/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class ProfileWatchedCell: BaseProfileMoviesCell {
    
    override var listName: String {
        get { return R.string.localizable.profileProfileWatchedTitle() }
        set {}
    }
}
