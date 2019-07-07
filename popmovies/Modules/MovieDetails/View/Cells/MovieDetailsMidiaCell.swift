//
//  MovieDetailsMidiaCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: MovieDetailsMidiaCell: UITableViewCell

class MovieDetailsMidiaCell: UITableViewCell {
    // MARK: Constants
    
    let VideosCollectionViewIdentifier          = "VideosCollectionViewIdentifier"
    let WallpapersCollectionViewIdentifier      = "WallpapersCollectionViewIdentifier"
    
    let VideoCell                               = R.nib.videoCell.name
    let WallpaperCell                           = R.nib.wallpaperCell.name
    let VideoCellIdentifier                     = "VideoCellIdentifier"
    let WallpaperCellIdentifier                 = "WallpaperCellIdentifier"
    
    // MARK: Outlets
    
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
    
    // MARK: Properties
    
    var allImages: [Image] = []
    var allVideos: [Video] = []
    
    var delegate: MovieDetailsMidiaDelegate?
    var movie: Movie? {
        didSet { bindMidiaContent(movie: movie!) }
    }
}

// MARK: Bind methods

extension MovieDetailsMidiaCell {
    
    private func bindMidiaContent(movie: Movie) {
        setupCells()
        
        allImages = movie.allImages
        allVideos = movie.videos?.videoResults ?? []
        
        if allVideos.count > 6 {
            allVideos = Array(allVideos[0..<6])
        }
        
        self.imagesCollectionViewView.reloadData()
        self.videosCollectionViewView.reloadData()
    }
    
    private func setupCells() {
        imagesCollectionViewView.configureNibs(nibName: WallpaperCell, identifier: WallpaperCellIdentifier)
        videosCollectionViewView.configureNibs(nibName: VideoCell, identifier: VideoCellIdentifier)
    }
    
}

// MARK: Action methods

extension MovieDetailsMidiaCell {
    
    @IBAction func didSeeAllVideosClicked(_ sender: Any) {
        delegate?.didSeeAllVideosClicked(allVideos)
    }
    
    @IBAction func didSeeAllImagesClicked(_ sender: Any) {
        delegate?.didSeeAllWallpapersClicked(allImages)
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension MovieDetailsMidiaCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.restorationIdentifier {
        case VideosCollectionViewIdentifier:
            return allVideos.count
        case WallpapersCollectionViewIdentifier:
            return allImages.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.restorationIdentifier {
        case VideosCollectionViewIdentifier:
            return setupVideosCollectionView(collectionView, cellForItemAt: indexPath)
        case WallpapersCollectionViewIdentifier:
            return setupWallpapersCollectionView(collectionView, cellForItemAt: indexPath)
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case VideosCollectionViewIdentifier:
            didVideoSelected(collectionView, didSelectItemAt: indexPath)
        case WallpapersCollectionViewIdentifier:
            didImageSelected(collectionView, didSelectItemAt: indexPath)
        default:
            return
        }
    }
    
    private func setupVideosCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let videos = movie?.videos?.videoResults else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCellIdentifier, for: indexPath) as! VideoCell
        let video = videos[indexPath.row]
        
        cell.video = video
        
        return cell
    }
    
    private func setupWallpapersCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WallpaperCellIdentifier, for: indexPath) as! WallpaperCell
        let image = allImages[indexPath.row]
        
        cell.image = image
        
        return cell
    }
    
    private func didVideoSelected(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = allVideos[indexPath.row]
        
        delegate?.didVideoSelected(video, allVideos)
    }
    
    private func didImageSelected(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = allImages[indexPath.row]
        
        delegate?.didImageSelected(image, allImages, indexPath: indexPath)
    }
    
}
