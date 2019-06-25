//
//  ImageListController.swift
//  popmovies
//
//  Created by Tiago Silva on 21/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

class ImageListController: BaseViewController {
    let ImageViewerControllerIdentifier     = "ImageViewerControllerIdentifier"
    let ImageListCellIdentifier             = "ImageListCellIdentifier"
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageQuantityLabel: UILabel!


    @IBOutlet weak var imageListCollectionView: UICollectionView!
    @IBOutlet weak var imageListCollectionViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            //imageListCollectionViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var allImages: [Image] = []
    var movie: Movie?
    var person: Person?
    
    lazy var cellSize: CGSize = CGSize(width: self.view.bounds.width / CGFloat(self.numberOfCollunms), height: self.view.bounds.width / CGFloat(self.numberOfCollunms))
    
    let numberOfCollunms = 2
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNibs(collection: imageListCollectionView, nibName: "ImageListItem", identifier: ImageListCellIdentifier)
        
        backButton.layer.cornerRadius = backButton.bounds.width / 2
        posterImage.layer.cornerRadius = posterImage.bounds.width / 2
        
        imageListCollectionView.indicatorStyle = .black
        backButton.imageView?.setImageColorBy(uiColor: UIColor.black)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageListCollectionView.reloadData()
        
        if let movie = self.movie {
            posterImage.setTMDBImageBy(url: movie.posterPath, contentSize: Constants.TMDB.ImageSize.POSTER.w154, contentMode: .scaleAspectFill, placeholder: nil)
            
            nameLabel.text = movie.title
            imageQuantityLabel.text = "\(allImages.count) Images"
            return
        }
        
        if let person = self.person {
            posterImage.setTMDBImageBy(url: person.profilePath, contentSize: Constants.TMDB.ImageSize.POSTER.w154, contentMode: .scaleAspectFill, placeholder: nil)
            
            nameLabel.text = person.name
            imageQuantityLabel.text = "\(allImages.count) Images"
        }
        
    }
    
    @IBAction func dismiss() {
        hero.dismissViewController()
    }
}

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
        if let controller = self.storyboard!.instantiateViewController(withIdentifier: ImageViewerControllerIdentifier) as? ImageViewerController {
            let image = allImages[indexPath.row]
            
            controller.hero.modalAnimationType = .fade
            controller.selectedIndex = indexPath
            controller.image = image
            controller.allImages = allImages
            controller.movie = movie
            controller.person = person
            
            self.present(controller, animated: true, completion: nil)
        }
    }
    
}

extension ImageListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
}

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
