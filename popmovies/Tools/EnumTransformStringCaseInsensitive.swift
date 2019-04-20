//
//  EnumTransformStringCaseInsensitive.swift
//  popmovies
//
//  Created by Tiago Silva on 18/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class EnumTransformStringCaseInsensitive<T: RawRepresentable>: TransformType {
    public typealias Object = T
    public typealias JSON = T.RawValue
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> T? {
        if let stringValue = value as? String {
            let aux = stringValue.lowercased()
            
            if let lowerCaseStringValue = aux as? T.RawValue {
                return T(rawValue: lowerCaseStringValue)
            }
        }
        return nil
    }
    
    open func transformToJSON(_ value: T?) -> T.RawValue? {
        if let obj = value {
            return obj.rawValue
        }
        return nil
    }
}
