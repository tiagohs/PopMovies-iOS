//
//  BaseContract.swift
//  popmovies
//
//  Created by Tiago Silva on 11/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol IBaseView {
    
}

protocol IBasePresenter {
    
    func onInit()
    func onDestroy()
}

protocol IBaseInteractor {
    
    func onInit<P: IBasePresenter>(presenter: P)
}
