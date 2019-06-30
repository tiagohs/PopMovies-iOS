//
//  PersonItem.swift
//  popmovies
//
//  Created by Tiago Silva on 20/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class PersonItem {
    var id: Int
    var name: String
    var subtitle: String
    var pictureId: String?
    
    init(id: Int, name: String, subtitle: String, pictureId: String?) {
        self.id = id
        self.name = name
        self.subtitle = subtitle
        self.pictureId = pictureId
    }
}
