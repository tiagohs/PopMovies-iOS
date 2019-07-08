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
    
    let numberOfCollunms = 4
    
    // MARK: Outlets
    
    @IBOutlet weak var personsCollectionView: UICollectionView!
    
    // MARK: Properties

    var persons: [PersonItem] = []
    var presenter: PersonListPresenterInterface?
    var infiniteScrollView: UIScrollView?
    
    lazy var cellSize: CGSize = CGSize(
        width: self.personsCollectionView.bounds.width / CGFloat(self.numberOfCollunms),
        height: CGFloat(110))
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

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension PersonListController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCellIdentifier, for: indexPath) as? PersonCell else {
            return UICollectionViewCell()
        }
        let person = persons[indexPath.row]
        cell.person = person
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = persons[indexPath.row]
        
        presenter?.didSelectPerson(person)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension PersonListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
}

// MARK: PersonListViewInterface - Setup Methods

extension PersonListController: PersonListViewInterface {
    
    func setupUI() {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        personsCollectionView.configureNibs(nibName: PersonCellName, identifier: PersonCellIdentifier)
        
        personsCollectionView.infiniteScrollIndicatorView = createDefaultActivityIndicator()
        personsCollectionView.infiniteScrollTriggerOffset = 500
        personsCollectionView.infiniteScrollIndicatorMargin = 20
        personsCollectionView.addInfiniteScroll { (scrollView) in
            
            scrollView.performBatchUpdates({ () -> Void in
                self.presenter?.fetchPersons()
            }, completion: { (finished) -> Void in
                
                scrollView.finishInfiniteScroll()
            })
        }
        
    }
}

extension PersonListController {
    
    func showPersons(with persons: [PersonItem]) {
        self.persons = persons
        
        personsCollectionView.reloadData()

        personsCollectionView.finishInfiniteScroll()
    }
    
    func stopInfiniteScroll() {
        personsCollectionView.setShouldShowInfiniteScrollHandler { _ -> Bool in
            return false
        }
    }
}
