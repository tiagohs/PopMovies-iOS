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
    // MARK: Constants
    
    let VideoListItem                       = R.nib.videoCell.name
    
    let VideoListCellIdentifier             = "VideoListCellIdentifier"
    
    // MARK: Outlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var videoListCollectionView: UICollectionView!
    @IBOutlet weak var videoListCollectionViewFlow: UICollectionViewFlowLayout!
    
    var presenter: VideoListPresenterInterface?
    
    var allVideos: [Video] = []
    lazy var cellSize: CGSize = CGSize(width: self.view.bounds.width / CGFloat(self.numberOfCollunms), height: self.view.bounds.width / CGFloat(self.numberOfCollunms))
    let numberOfCollunms = 3
    
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
        return allVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoListCellIdentifier, for: indexPath) as? VideoCell else {
            return UICollectionViewCell()
        }
        let video = allVideos[indexPath.row]
        
        cell.video = video
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = allVideos[indexPath.row]
        
        self.presenter?.didSelectVideo(video, indexPath: indexPath)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension VideoListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
}

// MARK: VideoListViewInterface

extension VideoListController: VideoListViewInterface {
    
    func setupUI() {
        self.videoListCollectionView.configureNibs(nibName: VideoListItem, identifier: VideoListCellIdentifier)
    }
    
    func bindUI(_ posterPath: String?, _ quantityContent: String, _ title: String?) {
        posterImage.setTMDBImageBy(url: posterPath, contentSize: TMDB.ImageSize.POSTER.w154, contentMode: .scaleAspectFill, placeholder: nil)
        
        nameLabel.text = title
        quantityLabel.text = quantityContent
    }
}

extension VideoListController {
    
    func showVideos(with videos: [Video]) {
        self.allVideos = videos
        
        self.videoListCollectionView.reloadData()
    }
}
