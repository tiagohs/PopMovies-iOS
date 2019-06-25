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
    
    func setImage(imageUrl: String, contentMode: UIView.ContentMode?, placeholderImageName: String?, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        let url = URL(string: imageUrl)
        
        let imageContentMode = contentMode == nil ? .scaleAspectFill : contentMode
        
        self.contentMode = imageContentMode!
        
        if let placeholder = placeholderImageName {
            self.kf.setImage(
                with: url,
                placeholder: UIImage(named: placeholder),
                options: [
                    .processor(DefaultImageProcessor.default),
                    .transition(.fade(1))
                ],
                completionHandler: completionHandler)
        } else {
            self.kf.setImage(
                with: url,
                options: [
                    .processor(DefaultImageProcessor.default),
                    .transition(.fade(1))
                ],
                completionHandler: completionHandler)
        }
        
    }
    
    func setImage(image: UIImage?, animation: UIView.AnimationOptions, duration: Double = 0.75) {
        UIView.transition(with: self,
                          duration: duration,
                          options: animation,
                          animations: { self.image = image },
                          completion: nil)
    }
    
    func setTMDBImageBy(url: String?, contentSize: String, contentMode: UIView.ContentMode?, placeholder: String?) {
        if let imageUrl = ImageUtils.formatImageUrl(imageID: url, imageSize: contentSize) {
            setImage(imageUrl: imageUrl, contentMode: contentMode, placeholderImageName: placeholder)
        } else if let placeholder = placeholder {
            self.image = UIImage(named: placeholder)
        }
    }
    
    func setImageColorBy(hexColor: String) {
        let color = ViewUtils.UIColorFromHEX(hex: hexColor)
        
        setImageColorBy(uiColor: color)
    }
    
    func setImageColorBy(uiColor: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        
        self.image = templateImage
        self.tintColor = uiColor
    }
    
}
