//
//  Date.swift
//  popmovies
//
//  Created by Tiago Silva on 19/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

extension Date {
    
    var year: String {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let currentYearInt = (calendar?.component(NSCalendar.Unit.year, from: Date()))!
        
        return String(currentYearInt)
    }
    
    var month: String {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let currentMonthInt = (calendar?.component(NSCalendar.Unit.month, from: Date()))!
        
        return String(currentMonthInt)
    }
    
    func formatDate(pattner: String) {
        
    }
}
