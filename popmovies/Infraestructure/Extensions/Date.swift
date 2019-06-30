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
        let currentYearInt = (calendar?.component(NSCalendar.Unit.year, from: self))!
        
        return String(currentYearInt)
    }
    
    var month: String {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let currentMonthInt = (calendar?.component(NSCalendar.Unit.month, from: self))!
        
        return String(currentMonthInt)
    }
    
    func formatDate(pattner: String = "dd/MM/yyyy") -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = pattner
        
        return dateFormatterPrint.string(from: self);
    }
}
