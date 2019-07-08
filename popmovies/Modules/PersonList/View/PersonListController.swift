//
//  PersonListController.swift
//  popmovies
//
//  Created by Tiago Silva on 08/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//


import UIKit

// MARK: PersonListController: BaseViewController

class PersonListController: BaseViewController {
    
    // MARK: Properties

    var presenter: PersonListPresenterInterface?
}

// MARK: Lifecycle Methods

extension PersonListController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.presenter?.viewDidDisappear(animated)
    }
}

// MARK: PersonListViewInterface - Setup Methods

extension PersonListController: PersonListViewInterface {
    
    func setupUI() {
        
    }
    
}
