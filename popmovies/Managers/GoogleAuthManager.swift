//
//  GoogleAuthManager.swift
//  popmovies
//
//  Created by Tiago Silva on 09/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Firebase
import GoogleSignIn

// GoogleAuthManager

class GoogleAuthManager {
    
    static let shared = GoogleAuthManager()
    
    private init() {}
    
    var googleAuthDelegate: GoogleAuthDelegate?
    
    func startSignInFlow() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}

// MARK: Setup methods

extension GoogleAuthManager {
    
    func setup(delegate: GIDSignInDelegate) {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = delegate
    }
    
    func setupUI(delegate: GIDSignInUIDelegate) {
        GIDSignIn.sharedInstance().uiDelegate = delegate
    }
    
}

// MARK: GIDSignInDelegate Methods

extension GoogleAuthManager {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            googleAuthDelegate?.didSignFinished(with: DefaultError(message: error.localizedDescription))
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        googleAuthDelegate?.didSignFinished(with: credential)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
}

// MARK: Google URL Handle

extension GoogleAuthManager {
    
    func handle(open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    func handle(open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
}
