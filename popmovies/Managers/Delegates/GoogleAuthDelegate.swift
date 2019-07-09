//
//  GoogleAuthDelegate.swift
//  popmovies
//
//  Created by Tiago Silva on 09/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Firebase
import GoogleSignIn

protocol GoogleAuthDelegate {
    func didSignFinished(with credentials: AuthCredential)
    func didSignFinished(with error: DefaultError)
}
