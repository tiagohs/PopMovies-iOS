//
//  FacebookAuthManager.swift
//  popmovies
//
//  Created by Tiago Silva on 10/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookAuthManager {
    
    static let shared = FacebookAuthManager()
    
    let loginManager: LoginManager
    
    var delegate: FacebookAuthDelegate?
    
    private init() {
        self.loginManager = LoginManager()
    }
}

extension FacebookAuthManager {
    
    func startSignInFlow(from viewController: UIViewController) {
        self.loginManager.logIn(permissions: [ "public_profile", "email" ], from: viewController) { (loginResult, error) in
            guard error == nil, let token = loginResult?.token else {
                if loginResult?.isCancelled != nil {
                    self.delegate?.didSignCancelled()
                }
                
                self.delegate?.didSignFinished(with: DefaultError(message: R.string.localizable.loginFacebookUnknownError()))
                return
            }
            
            self.delegate?.didSignFinished(with: token)
        }
    }
    
}

extension FacebookAuthManager {
    
    func handle(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func handle(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
        return ApplicationDelegate.shared.application(application, open: url, options: options)
    }
    
    func isFacebookLoginHandle(open url: URL) -> Bool {
        guard let appId: String = Settings.appID else {
            return false
        }
        
        return url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize"
    }
    
}
