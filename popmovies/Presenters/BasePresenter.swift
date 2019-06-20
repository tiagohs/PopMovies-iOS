//
//  BasePresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 11/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import RxSwift

class BasePresenter: IBasePresenter {
    
    var disposibles: CompositeDisposable
    
    init() {
        disposibles = CompositeDisposable()
    }
    
    func onInit() {
        
    }
    
    func onDestroy() {
        disposibles.dispose()
    }
    
    func add(_ d: Disposable?) {
        if (d == nil) { return }
        
        disposibles.insert(d!)
    }
}
