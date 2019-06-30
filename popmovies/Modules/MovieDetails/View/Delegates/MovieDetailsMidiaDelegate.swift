//
//  MovieDetailsMidiaDelegate.swift
//  popmovies
//
//  Created by Tiago Silva on 30/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol MovieDetailsMidiaDelegate {
    
    func didVideoSelected(_ video: Video, _ allVideos: [Video])
    func didImageSelected(_ image: Image,_ allImages: [Image], indexPath: IndexPath)
    func didSeeAllVideosClicked(_ allVideos: [Video])
    func didSeeAllWallpapersClicked(_ allImages: [Image])
}
