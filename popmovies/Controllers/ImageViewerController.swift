//
//  ImageViewerController.swift
//  popmovies
//
//  Created by Tiago Silva on 21/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

class ImageViewerController: BaseViewController {
    let ImageViewerItemCellIdentifier = "ImageViewerItemCellIdentifier"
    
    @IBOutlet weak var panGesture: UIPanGestureRecognizer!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var imageViewerCollectionView: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var selectedIndex: IndexPath?
    
    var image: Image?
    var allImages: [Image]?
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        backButton.layer.cornerRadius = backButton.bounds.width / 2
        shareButton.layer.cornerRadius = shareButton.bounds.width / 2
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewerCollectionView.contentInsetAdjustmentBehavior = .always
        automaticallyAdjustsScrollViewInsets = false
        preferredContentSize = CGSize(width: view.bounds.width, height: view.bounds.width)
        
        view.layoutIfNeeded()
        imageViewerCollectionView.reloadData()
        
        if let selectedIndex = self.selectedIndex {
            imageViewerCollectionView.scrollToItem(at: selectedIndex, at: .centeredHorizontally, animated: false)
        }
        
        imageViewerCollectionView.addGestureRecognizer(panGesture)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        for v in (imageViewerCollectionView.visibleCells as? [ImageViewerItemCell])! {
            v.topInset = topLayoutGuide.length
        }
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
    
    @IBAction func dismiss() {
        hero.dismissViewController()
    }
}

extension ImageViewerController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewerItemCellIdentifier, for: indexPath) as? ImageViewerItemCell, let allImages = self.allImages else {
            return UICollectionViewCell()
        }
        let image = allImages[indexPath.row]
        
        if (cell.image == nil) {
            bindCell(cell, image, indexPath)
        }
        
        return cell
    }
    
    private func bindCell(_ cell: ImageViewerItemCell,_ image: Image,_ indexPath: IndexPath) {
        if let imageURL = ImageUtils.formatImageUrl(imageID: image.filePath, imageSize: Constants.TMDB.ImageSize.BACKDROP.w780) {
            
            cell.imageView.setImage( imageUrl: imageURL, contentMode: .scaleAspectFit, placeholderImageName: "BackdropPlaceholder")
            cell.imageView.hero.id = image.filePath
        }
        cell.imageView.hero.id = String(describing: image.filePath)
        cell.imageView.hero.modifiers = [.position(CGPoint(x:view.bounds.width/2, y:view.bounds.height+view.bounds.width/2)), .scale(0.6), .fade]
        cell.topInset = topLayoutGuide.length
        cell.imageView.isOpaque = true
        
        cell.imageView.hero.modifiers = [
            .position(CGPoint(
                x: view.bounds.width / 2,
                y: view.bounds.height + view.bounds.width / 2
                )
            ),
            .scale(0.6),
            .fade
        ]
        cell.topInset = topLayoutGuide.length
    }
    
}

extension ImageViewerController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.bounds.size
    }
}

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
