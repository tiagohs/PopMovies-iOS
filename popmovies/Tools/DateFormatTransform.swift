//
//  DateFormatTransform.swift
//  popmovies
//
//  Created by Tiago Silva on 25/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import ObjectMapper

public class DateFormatTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = Double
    
    var dateFormat = DateFormatter()
    
    convenience init(_ format: String) {
        self.init()
        self.dateFormat.dateFormat = format
    }
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let timeInt = value as? Double {
            return Date(timeIntervalSince1970: TimeInterval(timeInt))
        }
        
        if let timeStr = value as? String {
            return self.dateFormat.date(from: timeStr)
        }
        
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> Double? {
        if let date = value {
            return Double(date.timeIntervalSince1970)
        }
        return nil
    }
}
