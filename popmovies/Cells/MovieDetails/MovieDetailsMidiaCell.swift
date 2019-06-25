//
//  MovieDetailsMidiaCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MovieDetailsMidiaCell: UITableViewCell {
    
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
    
    var midiaListener: IMidiaListener?
    var movie: Movie? {
        didSet { bindMidiaContent(movie: movie!) }
    }
    
    private func bindMidiaContent(movie: Movie) {
        setupCells()
        
        allImages = mergeImages(movie: movie)
        allVideos = movie.videos?.videoResults ?? []
        
        if allVideos.count > 6 {
            allVideos = Array(allVideos[0..<6])
        }
        
        self.imagesCollectionViewView.reloadData()
        self.videosCollectionViewView.reloadData()
    }
    
    private func setupCells() {
        configureNibs(imagesCollectionViewView, nibName: "WallpaperCell", identifier: wallpaperCellIdentifier)
        configureNibs(videosCollectionViewView, nibName: "VideoCell", identifier: videoCellIdentifier)
    }
    
    private func configureNibs(_ collection: UICollectionView, nibName: String, identifier: String) {
        let cellNib = UINib(nibName: nibName, bundle: nil)
        
        collection.register(cellNib, forCellWithReuseIdentifier: identifier)
        collection.reloadData()
    }
    
    private func mergeImages(movie: Movie) -> [Image] {
        let posters = movie.images?.backdrops ?? []
        let backdrop = movie.images?.posters ?? []
        
        if (posters.count > 3 && backdrop.count > 3) {
            return Array(backdrop[0..<3]) + Array(posters[0..<3])
        }
        
        return backdrop + posters
    }
    
    @IBAction func didSeeAllVideosClicked(_ sender: Any) {
        midiaListener?.didSeeAllVideosClicked(allVideos)
    }
    
    @IBAction func didSeeAllImagesClicked(_ sender: Any) {
        midiaListener?.didSeeAllWallpapersClicked(allImages)
    }
}

extension MovieDetailsMidiaCell: UICollectionViewDelegate, UICollectionViewDataSource {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case videosCollectionViewIdentifier:
            didVideoSelected(collectionView, didSelectItemAt: indexPath)
        case wallpapersCollectionViewIdentifier:
            didImageSelected(collectionView, didSelectItemAt: indexPath)
        default:
            return
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
    
    private func didVideoSelected(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = allVideos[indexPath.row]
        
        midiaListener?.didVideoSelected(video, allVideos)
    }
    
    private func didImageSelected(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = allImages[indexPath.row]
        
        midiaListener?.didImageSelected(image, allImages, indexPath: indexPath)
    }
    
}

protocol IMidiaListener {
    
    func didVideoSelected(_ video: Video, _ allVideos: [Video])
    func didImageSelected(_ image: Image,_ allImages: [Image], indexPath: IndexPath)
    func didSeeAllVideosClicked(_ allVideos: [Video])
    func didSeeAllWallpapersClicked(_ allImages: [Image])
}
