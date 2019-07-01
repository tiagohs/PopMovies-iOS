//
//  VideoListController.swift
//  popmovies
//
//  Created by Tiago Silva on 23/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: VideoListController: BaseViewController

class VideoListController: BaseViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var videoListCollectionView: UICollectionView!
    @IBOutlet weak var videoListCollectionViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            videoListCollectionViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    var presenter: VideoListPresenterInterface?
    
    var allVideos: [Video] = []
}

// MARK: Lifecycle Methods

extension VideoListController {
    
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
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate

extension VideoListController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
        //return allVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}

// MARK: VideoListViewInterface

extension VideoListController: VideoListViewInterface {
    
    func setupUI() {
        backButton.layer.cornerRadius = backButton.bounds.width / 2
        backButton.imageView?.setImageColorBy(uiColor: UIColor.white)
    }
    
}
