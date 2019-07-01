//
//  ImageViewerController.swift
//  popmovies
//
//  Created by Tiago Silva on 21/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

// MARK: ImageViewerController: BaseViewController

class ImageViewerController: BaseViewController {
    
    // MARK: Constants
    
    let ImageViewerItemCellIdentifier               = R.reuseIdentifier.imageViewerItemCellIdentifier.identifier
    
    // MARK: Outlets
    
    @IBOutlet weak var panGesture: UIPanGestureRecognizer!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var imageViewerCollectionView: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var presenter: ImageViewerPresenterInterface?
    
    var selectedIndex: IndexPath?
    
    var image: Image?
    var allImages: [Image] = []
}

// MARK: Lifecycle Methods

extension ImageViewerController {
    
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
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        presenter?.viewWillLayoutSubviews()
    }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate

extension ImageViewerController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewerItemCellIdentifier, for: indexPath) as? ImageViewerItemCell else {
            return UICollectionViewCell()
        }
        let image = allImages[indexPath.row]
        
        bindCell(cell, image, indexPath)
        
        return cell
    }
    
    private func bindCell(_ cell: ImageViewerItemCell,_ image: Image,_ indexPath: IndexPath) {
        cell.imageView.setTMDBImageBy(url: image.filePath, contentSize: TMDB.ImageSize.BACKDROP.w1280, contentMode: .scaleAspectFill, placeholder: nil)
        
        cell.imageView.hero.id = String(describing: image.filePath)
        cell.imageView.hero.modifiers = [.fade]
        cell.topInset = topLayoutGuide.length
        cell.imageView.isOpaque = true
        cell.topInset = topLayoutGuide.length
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension ImageViewerController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.bounds.size
    }
}

// MARK: UIGestureRecognizerDelegate

extension ImageViewerController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let cell = imageViewerCollectionView.visibleCells[0] as? ImageViewerItemCell,
            cell.scrollView.zoomScale == 1 {
            let v = panGesture.velocity(in: nil)
            
            return v.y > abs(v.x)
        }
        
        return false
    }
}

// MARK: ImageViewerViewInterface

extension ImageViewerController: ImageViewerViewInterface {
    
    func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        preferredContentSize = CGSize(width: view.bounds.width, height: view.bounds.width)
        view.layoutIfNeeded()
    }
    
    func setupButtons() {
        backButton.layer.cornerRadius = backButton.bounds.width / 2
        shareButton.layer.cornerRadius = shareButton.bounds.width / 2
        galleryButton.layer.cornerRadius = galleryButton.bounds.width / 2
    }
    
    func setupImageViewerCollectionView() {
        imageViewerCollectionView.contentInsetAdjustmentBehavior = .always
        imageViewerCollectionView.reloadData()
        
        if let selectedIndex = self.selectedIndex {
            imageViewerCollectionView.scrollToItem(at: selectedIndex, at: .centeredHorizontally, animated: false)
        }
        
        imageViewerCollectionView.addGestureRecognizer(panGesture)
    }
    
    func setupImageCollectionViewCells() {
        for v in (imageViewerCollectionView.visibleCells as? [ImageViewerItemCell])! {
            v.topInset = topLayoutGuide.length
        }
    }
}

// MARK: Actions Methods

private extension ImageViewerController {
    
    @IBAction func dismiss() {
        hero.dismissViewController()
    }
    
    @IBAction func didGalleryButtonClicked() {
        presenter?.didSeeAllImagesClicked()
    }
    
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: nil)
        let progress = translation.y / 2 / imageViewerCollectionView.bounds.height
        
        switch sender.state {
        case .began:
            dismiss()
        case .changed:
            Hero.shared.update(progress)
            
            if let cell = imageViewerCollectionView.visibleCells[0]  as? ImageListItemCell {
                let currentPos = CGPoint(x: translation.x + view.center.x, y: translation.y + view.center.y)
                
                Hero.shared.apply(modifiers: [.position(currentPos)], to: cell.imageView)
            }
        default:
            let y = panGesture.velocity(in: nil).y
            let collectionViewHeight = imageViewerCollectionView.bounds.height
            
            if progress + y / collectionViewHeight > 0.3 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    
}
