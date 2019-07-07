//
//  CalendarDelegate.swift
//  popmovies
//
//  Created by Tiago Silva on 06/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol CalendarDelegate {
    
    func didSelectNewDate(_ startDate: Date, _ endDate: Date)
}
