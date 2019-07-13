//
//  TwitterAuthManager.swift
//  popmovies
//
//  Created by Tiago Silva on 11/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import Firebase
import TwitterKit

class TwitterAuthManager {
    
    static let shared = TwitterAuthManager()
    
    var delegate: TwitterAuthDelegate?
    
    private init() {
        
    }
}

extension TwitterAuthManager {
    
    func setup() {
        TWTRTwitter.sharedInstance().start(withConsumerKey: Constants.TWITTER.CONSUMER_KEY, consumerSecret: Constants.TWITTER.CONSTUMER_SECRET)
    }
    
}


extension TwitterAuthManager {
    
    func startSignInFlow(from viewController: UIViewController) {
        TWTRTwitter.sharedInstance().logIn(with: viewController) { (session, error) in
            guard error == nil, let token = session?.authToken, let tokenSecret = session?.authTokenSecret else {
                self.delegate?.didSignFinished(with: DefaultError(message: error!.localizedDescription))
                return
            }
            let credentials = TwitterAuthProvider.credential(withToken: token, secret: tokenSecret)
            
            self.delegate?.didTwitterSignFinished(with: credentials)
        }
        
    }
    
}

extension TwitterAuthManager {
    
    func handle(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
            return TWTRTwitter.sharedInstance().application(application, open: url, options: options)
    }
}
