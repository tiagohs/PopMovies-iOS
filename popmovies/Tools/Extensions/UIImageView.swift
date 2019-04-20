//
//  UIImageView.swift
//  popmovies
//
//  Created by Tiago Silva on 16/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func setImage(imageUrl: String, contentMode: UIView.ContentMode?, placeholderImageName: String, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        let url = URL(string: imageUrl)
        
        let imageContentMode = contentMode == nil ? .scaleAspectFill : contentMode
        
        self.contentMode = imageContentMode!
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: placeholderImageName),
            options: [
                .processor(DefaultImageProcessor.default),
                .transition(.fade(1))
            ],
            completionHandler: completionHandler)
    }
}
