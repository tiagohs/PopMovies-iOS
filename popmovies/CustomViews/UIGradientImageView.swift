//
//  UIGradientImageView.swift
//  popmovies
//
//  Created by Tiago Silva on 20/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import UIKit
import Hero

class UIGradientImageView: UIImageView {
    var myGradientLayer: CAGradientLayer? = nil
    
    var colors: [CGColor]? = nil
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.setup()
        addGradientLayer()
    }
    
    func addGradientLayer(){
        if let gradient = myGradientLayer {
            self.layer.addSublayer(gradient)
        }
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        self.setup()
        addGradientLayer()
    }
    
    func getLocations() -> [CGFloat]{
        return [0.2,  0.9]
    }
    
    func updateColors(colors: [CGColor]) {
        self.colors = colors
        
        self.setup()
        addGradientLayer()
    }
    
    func setup() {
        
        if (colors != nil) {
            myGradientLayer = CAGradientLayer()
            
            myGradientLayer!.startPoint = CGPoint(x: 0.6, y: 0)
            myGradientLayer!.endPoint = CGPoint(x: 0.6, y: 1)
            
            
            myGradientLayer!.colors = colors
            myGradientLayer!.isOpaque = false
            myGradientLayer!.locations = getLocations() as [NSNumber]?
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myGradientLayer?.frame = self.layer.bounds
    }
}
