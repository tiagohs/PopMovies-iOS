//
//  Localizable+Extensions.swift
//  popmovies
//
//  Created by Tiago Silva on 18/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}
