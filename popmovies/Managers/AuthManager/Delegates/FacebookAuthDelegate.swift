//
//  FacebookAuthDelegate.swift
//  popmovies
//
//  Created by Tiago Silva on 13/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

protocol FacebookAuthDelegate {
    func didSignFinished(with token: AccessToken)
    func didSignFinished(with error: DefaultError)
    func didSignCancelled()
}
