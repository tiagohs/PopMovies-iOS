//
//  ObservableType.swift
//  popmovies
//
//  Created by Tiago Silva on 14/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

extension ObservableType {
    public func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
        return flatMap { data -> Observable<T> in
            guard let (_, object) = data as? (HTTPURLResponse, Any),
                let value = Mapper<T>().map(JSONObject: object) else {
                    throw NSError(
                        domain: "com.example",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
                    )
            }
            return Observable.just(value)
        }
    }
    
    public func mapArray<T: Mappable>(type: T.Type) -> Observable<[T]> {
        return flatMap { data -> Observable<[T]> in
            guard let (_, objects) = data as? (HTTPURLResponse, Any),
                let values = Mapper<T>().mapArray(JSONObject: objects) else {
                    throw NSError(
                        domain: "com.example",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
                    )
            }
            return Observable.just(values)
        }
    }
}
