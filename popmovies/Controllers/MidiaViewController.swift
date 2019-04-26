//
//  MidiaViewController.swift
//  popmovies
//
//  Created by Tiago Silva on 23/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MidiaViewController: UIViewController {
    
    let videosCollectionViewIdentifier = "VideosCollectionViewIdentifier"
    let wallpapersCollectionViewIdentifier = "WallpapersCollectionViewIdentifier"
    
    let videoCellIdentifier = "VideoCellIdentifier"
    let wallpaperCellIdentifier = "WallpaperCellIdentifier"
    
    var allImages: [String] = []
    
    var movie: Movie? {
        didSet { bindFooter(movie: movie!) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func bindFooter(movie: Movie) {
        allImages = mergeImages(movie: movie)
        
    }
    
    private func mergeImages(movie: Movie) -> [String] {
        let posters = movie.images?.backdrops ?? []
        let backdrop = movie.images?.posters ?? []
        
        return backdrop + posters
    }
}

extension MidiaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.restorationIdentifier {
        case videosCollectionViewIdentifier:
            return movie?.videos?.videoResults?.count ?? 0
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoCellIdentifier, for: indexPath) as! WallpaperCell
        let image = allImages[indexPath.row]
        
        cell.image = image
        
        return cell
    }

}
