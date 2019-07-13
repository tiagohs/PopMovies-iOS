//
//  ProfileManager.swift
//  popmovies
//
//  Created by Tiago Silva on 13/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import Firebase

class ProfileManager {
    
    static let shared = ProfileManager()
    
    let firebaseAuth: Auth!
    
    private init() {
        self.firebaseAuth = Auth.auth()
    }
    
}

extension ProfileManager {
    
    func getCurrentUser() -> UserLocal {
        return self.createUser()
    }
    
}

extension ProfileManager {
    
    func updateProfile(name: String?, photoUrl: String? = nil, completionHandler: @escaping (DefaultError?) -> Void) {
        if firebaseAuth.currentUser == nil { return }
        
        let changeRequest = firebaseAuth.currentUser?.createProfileChangeRequest()
        
        if let name = name {
            changeRequest?.displayName = name
        }
        
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

extension ProfileManager {
    
    func createUser() -> UserLocal {
        let user = UserLocal()
        
        user.email = self.firebaseAuth?.currentUser?.email
        user.name = self.firebaseAuth?.currentUser?.displayName
        user.photoURL = self.firebaseAuth?.currentUser?.photoURL
        
        return user
    }
    
    
}
