//
//  ImageUtils.swift
//  popmovies
//
//  Created by Tiago Silva on 22/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class ImageUtils {
    
    static func formatImageUrl(imageID: String?, imageSize: String) -> String? {
        guard let id = imageID else {
            return nil
        }
        
        return "\(TMDB.BASE_IMAGE_URL)\(imageSize)/\(id)"
    }
}
