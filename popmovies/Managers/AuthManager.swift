//
//  AuthManager.swift
//  popmovies
//
//  Created by Tiago Silva on 09/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import Firebase

class AuthManager {
    
    static let shared = AuthManager()
    
    let firebaseAuth: Auth!
    
    var signInCompletion: ((UserLocal?, DefaultError?) -> Void)?
    
    private init() {
        firebaseAuth = Auth.auth()
    }
    
    func getRootControllerByUserStatus() -> UIViewController {
        let rootController = RootWireframe.buildModule()
        let welcomeController = WelcomeWireframe.buildModule()
        
        return isUserLogged() ? rootController : welcomeController
    }
}

// MARK: Login Manager

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
        
    }
    
    private func signInWithTwitter(_ signInCompletionHandler: @escaping (UserLocal?, DefaultError?) -> Void) {
        
    }
    
    private func signInWithGoogle(_ signInCompletionHandler: @escaping (UserLocal?, DefaultError?) -> Void) {
        self.signInCompletion = signInCompletionHandler
        
        GoogleAuthManager.shared.googleAuthDelegate = self
        GoogleAuthManager.shared.startSignInFlow()
    }
}

// MARK: GoogleAuthDelegate

extension AuthManager: GoogleAuthDelegate {
    
    func didSignFinished(with credentials: AuthCredential) {
        firebaseAuth.signIn(with: credentials) { (authDataResult, error) in
            self.onAuthResult(authDataResult, error, self.signInCompletion)
        }
    }
    
    func didSignFinished(with error: DefaultError) {
        self.signInCompletion?(nil, DefaultError(message: error.localizedDescription))
    }
    
}

// MARK: Profile Manager

extension AuthManager {
    
    func signUp(with email: String, _ password: String, _ name: String, signUpCompletionHandler: @escaping (UserLocal?, DefaultError?) -> Void) {
        firebaseAuth.createUser(withEmail: email, password: password) { (authDataResult, error) in
            if error != nil {
                let message = error?.localizedDescription ?? "Error during the register, try again."
                
                signUpCompletionHandler(nil, DefaultError(message: message))
                return
            }
            
            self.updateProfile(name: name, completionHandler: { (error) in
                if let error = error {
                    signUpCompletionHandler(nil, DefaultError(message: error.localizedDescription))
                    return
                }
                
                signUpCompletionHandler(self.createUser(), nil)
            })
            
        }
    }
    
    func updateProfile(name: String?, photoUrl: String? = nil, completionHandler: @escaping (DefaultError?) -> Void) {
        if firebaseAuth.currentUser == nil { return }
        
        let changeRequest = firebaseAuth.currentUser?.createProfileChangeRequest()
        
        changeRequest?.displayName = name
        
        if let photoUrl = photoUrl{
            changeRequest?.photoURL = URL(string: photoUrl)
        }
        
        changeRequest?.commitChanges(completion: { (error) in
            if let error = error {
                completionHandler(DefaultError(message: error.localizedDescription))
                return
            }
            
            completionHandler(nil)
        })
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
        
        return user
    }
    
    private func onAuthResult(_ authDataResult: AuthDataResult?, _ error: Error?, _ signInCompletionHandler: ((UserLocal?, DefaultError?) -> Void)?) {
        if let error = error {
            signInCompletionHandler?(nil, DefaultError(message: error.localizedDescription))
            return
        }
        
        signInCompletionHandler?(self.createUser(), nil)
    }
}
