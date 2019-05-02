//
//  MidiaViewController.swift
//  popmovies
//
//  Created by Tiago Silva on 23/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MidiaViewController: BaseViewController {
    
    let videosCollectionViewIdentifier = "VideosCollectionViewIdentifier"
    let wallpapersCollectionViewIdentifier = "WallpapersCollectionViewIdentifier"
    
    let videoCellIdentifier = "VideoCellIdentifier"
    let wallpaperCellIdentifier = "WallpaperCellIdentifier"
    
    @IBOutlet weak var imagesCollectionViewView: UICollectionView!
    @IBOutlet weak var videosCollectionViewView: UICollectionView!
    @IBOutlet weak var imagesCollectionViewViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            imagesCollectionViewViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    @IBOutlet weak var videosCollectionViewViewFlow: UICollectionViewFlowLayout!  {
        didSet {
            videosCollectionViewViewFlow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    var allImages: [Image] = []
    var allVideos: [Video] = []
    
    var movie: Movie? {
        didSet { bindMidiaContent(movie: movie!) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNibs(collection: imagesCollectionViewView, nibName: "WallpaperCell", identifier: wallpaperCellIdentifier)
        configureNibs(collection: videosCollectionViewView, nibName: "VideoCell", identifier: videoCellIdentifier) 
    }
    
    private func bindMidiaContent(movie: Movie) {
        allImages = mergeImages(movie: movie)
        allVideos = movie.videos?.videoResults ?? []
        
        if allVideos.count > 6 {
            allVideos = Array(allVideos[0..<6])
        }
        
        self.imagesCollectionViewView.reloadData()
        self.videosCollectionViewView.reloadData()
    }
    
    private func mergeImages(movie: Movie) -> [Image] {
        let posters = movie.images?.backdrops ?? []
        let backdrop = movie.images?.posters ?? []
        
        if (posters.count > 3 && backdrop.count > 3) {
            return Array(backdrop[0..<3]) + Array(posters[0..<3])
        }
        
        return backdrop + posters
    }
}

extension MidiaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.restorationIdentifier {
        case videosCollectionViewIdentifier:
            return allVideos.count
        case wallpapersCollectionViewIdentifier:
            return allImages.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.restorationIdentifier {
        case videosCollectionViewIdentifier:
            return setupVideosCollectionView(collectionView, cellForItemAt: indexPath)
        case wallpapersCollectionViewIdentifier:
            return setupWallpapersCollectionView(collectionView, cellForItemAt: indexPath)
        default:
            return UICollectionViewCell()
        }
        
    }
    
    private func setupVideosCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let videos = movie?.videos?.videoResults else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoCellIdentifier, for: indexPath) as! VideoCell
        let video = videos[indexPath.row]
        
        cell.video = video
        
        return cell
    }
    
    private func setupWallpapersCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: wallpaperCellIdentifier, for: indexPath) as! WallpaperCell
        let image = allImages[indexPath.row]
        
        cell.image = image
        
        return cell
    }

}
