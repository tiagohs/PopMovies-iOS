
//
//  CalendarPresenter.swift
//  popmovies
//
//  Created by Tiago Silva on 06/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

// MARK: CalendarPresenter

class CalendarPresenter {
    
    var view: CalendarViewInterface?
    var interactor: CalendarInteractorInputInterface?
    var wireframe: CalendarWireframeInterface?
    
    init(view: CalendarViewInterface?) {
        self.view = view
    }
    
}

// MARK: HomePresenterInterface - Lifecycle methods

extension CalendarPresenter: CalendarPresenterInterface {
    
    func viewDidLoad() {
        self.view?.setupUI()
    }
    
    func viewDidDisappear(_ animated: Bool) {
        self.interactor?.outputFinished()
    }
    
    func viewWillAppear(_ animated: Bool) {}
    
    func viewWillDisappear(_ animated: Bool) {}
    
}

extension CalendarPresenter: CalendarInteractorOutputInterface {
    
}
