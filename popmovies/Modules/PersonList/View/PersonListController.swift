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
    // MARK: Constants
    
    let PersonCellIdentifier                     = "PersonCellIdentifier"
    let PersonCellName                           = R.nib.personCell.name
    
    let numberOfCollunms = 2
    
    // MARK: Outlets
    
    @IBOutlet weak var personsCollectionView: UICollectionView!
    
    // MARK: Properties

    var persons: [Person]?
    var presenter: PersonListPresenterInterface?
    
    lazy var cellSize: CGSize = CGSize(width: self.personsCollectionView.bounds.width / CGFloat(self.numberOfCollunms), height: (self.personsCollectionView.bounds.width / CGFloat(self.numberOfCollunms)) + CGFloat(115))
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

extension PersonListController {
    
    func showPersons(with persons: [Person]) {
        
    }
}
