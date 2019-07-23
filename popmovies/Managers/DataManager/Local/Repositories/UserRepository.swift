//
//  UserRepository.swift
//  popmovies
//
//  Created by Tiago Silva on 18/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: UserRepository: BaseRepository<UserDB>, UserRepositoryInterface

class UserRepository: BaseRepository<UserDB>, UserRepositoryInterface {
    
    init() {
        super.init(UserDB.tableName, UserDB.tableRows.creationDate)
    }
}

// MARK: Default Methods

extension UserRepository {
    
    func add(with user: UserDB, complationHandler: ((DefaultError?) -> Void)?) {
        self.addItem(with: user, complationHandler: complationHandler)
    }
    
    func remove(with user: UserDB, complationHandler: ((DefaultError?) -> Void)?) {
        self.removeItem(with: user, complationHandler: complationHandler)
    }
    
    func getAll() -> [UserDB] {
        return self.items
    }
    
    func get(with user: UserDB) -> UserDB? {
        return self.items.first { (userSaved) -> Bool in return userSaved.email == user.email }
    }
}

// MARK: UserRepository Custom Methods

extension UserRepository {
    
    
    
}
