//
//  AuthManager.swift
//  popmovies
//
//  Created by Tiago Silva on 09/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit

// MARK: AuthManager

class AuthManager {
    
    static let shared = AuthManager()
    
    let firebaseAuth: Auth!
    
    var viewController: UIViewController?
    var signInCompletion: ((UserLocal?, DefaultError?) -> Void)?
    
    var isFacebook = false
    var isGoogle = false
    var isTwitter = false
    
    private init() {
        firebaseAuth = Auth.auth()
    }
    
    func getRootControllerByUserStatus() -> UIViewController {
        let rootController = RootWireframe.buildModule()
        let welcomeController = WelcomeWireframe.buildModule()
        
        return isUserLogged() ? rootController : welcomeController
    }
}

// MARK: Sign In

extension AuthManager {
    
    func signIn(with email: String, _ password: String, signInCompletionHandler: @escaping (UserLocal?, DefaultError?) -> Void) {
        firebaseAuth.signIn(withEmail: email, password: password) { (authDataResult, error) in
            self.onAuthResult(authDataResult, error, signInCompletionHandler)
        }
    }
    
    func signIn(with loginMethod: LoginMethod, signInCompletionHandler: @escaping (UserLocal?, DefaultError?) -> Void) {
        switch loginMethod {
        case .facebook:
            return signInWithFacebook(signInCompletionHandler)
        case .twitter:
            return signInWithTwitter(signInCompletionHandler)
        case .google:
            return signInWithGoogle(signInCompletionHandler)
        }
    }
    
    func signIn(with credentials: AuthCredential) {
        firebaseAuth.signIn(with: credentials) { (authDataResult, error) in
            self.onAuthResult(authDataResult, error, self.signInCompletion)
        }
    }
    
    func signOut(signOutCompletionHandler: @escaping (DefaultError?) -> Void) {
        if !isUserLogged() { return }
        
        do {
            try firebaseAuth.signOut()
            signOutCompletionHandler(nil)
        } catch let signOutError as NSError {
            signOutCompletionHandler(DefaultError(message: signOutError.localizedDescription))
        }
        
    }
    
}

// MARK: Social Login

extension AuthManager {
    
    private func signInWithFacebook(_ signInCompletionHandler: @escaping (UserLocal?, DefaultError?) -> Void) {
        self.signInCompletion = signInCompletionHandler
        
        FacebookAuthManager.shared.delegate = self
        
        if let viewController = self.viewController {
            FacebookAuthManager.shared.startSignInFlow(from: viewController)
        }
    }
    
    private func signInWithTwitter(_ signInCompletionHandler: @escaping (UserLocal?, DefaultError?) -> Void) {
        self.signInCompletion = signInCompletionHandler
        
        TwitterAuthManager.shared.delegate = self
        
        if let viewController = self.viewController {
            TwitterAuthManager.shared.startSignInFlow(from: viewController)
        }
    }
    
    private func signInWithGoogle(_ signInCompletionHandler: @escaping (UserLocal?, DefaultError?) -> Void) {
        self.signInCompletion = signInCompletionHandler
        
        GoogleAuthManager.shared.delegate = self
        GoogleAuthManager.shared.startSignInFlow()
    }
}

// MARK: GoogleAuthDelegate

extension AuthManager: GoogleAuthDelegate {
    
    func didSignFinished(with credentials: AuthCredential) {
        self.isGoogle = true
        
        self.signIn(with: credentials)
    }
    
    func didSignFinished(with error: DefaultError) {
        self.signInCompletion?(nil, DefaultError(message: error.localizedDescription))
    }
    
}

// MARK: FacebookAuthDelegate

extension AuthManager: FacebookAuthDelegate {
    
    func didSignFinished(with token: AccessToken) {
        let credentials = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
        self.isFacebook = true
        
        self.signIn(with: credentials)
    }
    
    func didSignCancelled() {
        self.signInCompletion?(nil, DefaultError(message:  R.string.localizable.loginUnknownError()))
    }
    
}

// MARK: TwitterAuthDelegate

extension AuthManager: TwitterAuthDelegate {
    
    func didTwitterSignFinished(with credentials: AuthCredential) {
        self.isTwitter = true
        
        self.signIn(with: credentials)
    }
    
}

// MARK: Profile Manager

extension AuthManager {
    
    func signUp(with email: String, _ password: String, _ name: String, signUpCompletionHandler: @escaping (UserLocal?, DefaultError?) -> Void) {
        firebaseAuth.createUser(withEmail: email, password: password) { (authDataResult, error) in
            if error != nil {
                let message = error?.localizedDescription ?? R.string.localizable.registerUnknownError()
                
                signUpCompletionHandler(nil, DefaultError(message: message))
                return
            }
            
            ProfileManager.shared.updateProfile(name: name, completionHandler: { (error) in
                if let error = error {
                    signUpCompletionHandler(nil, DefaultError(message: error.localizedDescription))
                    return
                }
                
                signUpCompletionHandler(self.createUser(), nil)
            })
            
        }
    }
    
}

// MARK: Helper Methods

extension AuthManager {
    
    func isUserLogged() -> Bool {
        return firebaseAuth.currentUser != nil
    }
    
    func createUser() -> UserLocal {
        let user = UserLocal()
        
        user.email = self.firebaseAuth?.currentUser?.email
        user.name = self.firebaseAuth?.currentUser?.displayName
        user.photoURL = self.firebaseAuth?.currentUser?.photoURL
        user.isTwitter = self.isTwitter
        user.isFacebook = self.isFacebook
        user.isGoogle = self.isGoogle
        
        return user
    }
    
    private func onAuthResult(_ authDataResult: AuthDataResult?, _ error: Error?, _ signInCompletionHandler: ((UserLocal?, DefaultError?) -> Void)?) {
        if let error = error {
            signInCompletionHandler?(nil, DefaultError(message: error.localizedDescription))
            resetValues()
            return
        }
        
        signInCompletionHandler?(self.createUser(), nil)
        
        resetValues()
    }
    
    private func resetValues() {
        isFacebook = false
        isGoogle = false
        isTwitter = false
    }
}
