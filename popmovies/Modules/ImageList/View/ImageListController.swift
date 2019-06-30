//
//  ImageListController.swift
//  popmovies
//
//  Created by Tiago Silva on 21/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

// MARK: ImageListController: BaseViewController

class ImageListController: BaseViewController {
    // MARK: Constants
    
    let ImageListItem                       = R.nib.imageListItem.name
    
    let ImageViewerControllerIdentifier     = "ImageViewerControllerIdentifier"
    let ImageListCellIdentifier             = "ImageListCellIdentifier"
    
    // MARK: Outlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageQuantityLabel: UILabel!

    @IBOutlet weak var imageListCollectionView: UICollectionView!
    @IBOutlet weak var imageListCollectionViewFlow: UICollectionViewFlowLayout!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Properties
    
    var presenter: ImageListPresenterInterface?
    
    var allImages: [Image] = []
    
    lazy var cellSize: CGSize = CGSize(width: self.view.bounds.width / CGFloat(self.numberOfCollunms), height: self.view.bounds.width / CGFloat(self.numberOfCollunms))
    
    let numberOfCollunms = 2
}

// MARK: Lifecycle Methods

extension ImageListController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter?.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter?.viewDidDisappear(animated)
        presenter = nil
    }
    
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate

extension ImageListController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageListCellIdentifier, for: indexPath) as? ImageListItemCell else {
            return UICollectionViewCell()
        }
        let image = allImages[indexPath.row]
        
        cell.image = image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = allImages[indexPath.row]
        
        presenter?.didSelectImage(image, indexPath: indexPath)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension ImageListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
}

// MARK: ImageListViewInterface

extension ImageListController: ImageListViewInterface {
    
    func setupUI() {
        imageListCollectionView.configureNibs(nibName: ImageListItem, identifier: ImageListCellIdentifier)
        
        backButton.layer.cornerRadius = backButton.bounds.width / 2
        posterImage.layer.cornerRadius = posterImage.bounds.width / 2
        
        imageListCollectionView.indicatorStyle = .black
        backButton.imageView?.setImageColorBy(uiColor: UIColor.black)
        
        imageListCollectionView.reloadData()
    }
    
    func bindUI(_ posterPath: String?, _ imageQuantity: String, _ title: String) {
        posterImage.setTMDBImageBy(url: posterPath, contentSize: TMDB.ImageSize.POSTER.w154, contentMode: .scaleAspectFill, placeholder: nil)
        
        nameLabel.text = title
        imageQuantityLabel.text = imageQuantity
    }
}

// MARK: HeroViewControllerDelegate

extension ImageListController: HeroViewControllerDelegate {
    
    func heroWillStartAnimatingTo(viewController: UIViewController) {
        if viewController is ImageListController {
            imageListCollectionView.hero.modifiers = [
                .cascade(
                    delta: 0.015,
                    direction: .bottomToTop,
                    delayMatchedViews: true
                )
            ]
        } else if viewController is ImageViewerController {
            if let cellIndex = imageListCollectionView.indexPathsForSelectedItems?.first,
                let cell = imageListCollectionView.cellForItem(at: cellIndex) {
                imageListCollectionView.hero.modifiers = [
                    .cascade(
                        delta: 0.015,
                        direction: .radial(center: cell.center),
                        delayMatchedViews: true
                    )
                ]
            }
        } else {
            imageListCollectionView.hero.modifiers = [
                .cascade(delta: 0.015)
            ]
        }
    }
    
    func heroWillStartAnimatingFrom(viewController: UIViewController) {
        if viewController is ImageListController {
            imageListCollectionView.hero.modifiers = [
                .cascade(delta: 0.015),
                .delay(0.25)
            ]
        } else {
            imageListCollectionView.hero.modifiers = [
                .cascade(delta: 0.015)
            ]
        }
        
        if let controller = viewController as? ImageViewerController,
            let originalCellIndex = controller.selectedIndex,
            let currentCellIndex = controller.imageViewerCollectionView?.indexPathsForVisibleItems[0],
            let targetAttribute = imageListCollectionView.layoutAttributesForItem(at: currentCellIndex) {
            
            imageListCollectionView.hero.modifiers = [
                .cascade(
                    delta: 0.015,
                    direction: .inverseRadial(center: targetAttribute.center)
                )
            ]
            
            if (!imageListCollectionView.indexPathsForVisibleItems.contains(currentCellIndex)) {
                imageListCollectionView.scrollToItem(
                    at: currentCellIndex,
                    at: originalCellIndex < currentCellIndex ? .bottom : .top,
                    animated: false
                )
            }
        }
    }
}

// MARK: Actions Methods

private extension MovieListController {
    
    @IBAction func dismiss() {
        hero.dismissViewController()
    }
}
