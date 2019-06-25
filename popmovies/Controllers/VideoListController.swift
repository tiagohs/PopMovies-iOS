//
//  VideoListController.swift
//  popmovies
//
//  Created by Tiago Silva on 23/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class VideoListController: BaseViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var videoListCollectionView: UICollectionView!
    @IBOutlet weak var videoListCollectionViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            videoListCollectionViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    var allVideos: [Video] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        backButton.layer.cornerRadius = backButton.bounds.width / 2
    }
}


extension VideoListController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
