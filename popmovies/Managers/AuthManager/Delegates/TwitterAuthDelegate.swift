//
//  TwitterAuthDelegate.swift
//  popmovies
//
//  Created by Tiago Silva on 13/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Firebase

protocol TwitterAuthDelegate {
    func didTwitterSignFinished(with credentials: AuthCredential)
    func didSignFinished(with error: DefaultError)
}

