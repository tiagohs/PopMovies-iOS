//
//  WeekPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class WeekPresenter {
    
    var view: WeekViewInterface?
    var interactor: WeekInteractorInputInterface?
    var wireframe: WeekWireframeInterface?
    
    init(view: WeekViewInterface?) {
        self.view = view
    }
    
}

extension WeekPresenter: WeekPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

extension WeekPresenter: WeekInteractorOutputInterface {
    
}
