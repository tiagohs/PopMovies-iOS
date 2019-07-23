//
//  UserRepositoryInterface.swift
//  popmovies
//
//  Created by Tiago Silva on 18/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol UserRepositoryInterface {
    func add(with user: UserDB, complationHandler: ((DefaultError?) -> Void)?)
    func remove(with user: UserDB, complationHandler: ((DefaultError?) -> Void)?)
    func getAll() -> [UserDB]
    func get(with user: UserDB) -> UserDB?
}
