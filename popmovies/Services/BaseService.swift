//
//  BaseService.swift
//  popmovies
//
//  Created by Tiago Silva on 14/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class BaseService {
    
    let baseUrl: String
    let baseParameters: [String : String]
    
    init() {
        baseUrl = Constants.TMDB.BASE_URL
        baseParameters =
                    [
                        Constants.TMDB.Parameters.apiKey: Constants.TMDB.API_KEY,
                        Constants.TMDB.Parameters.language: "pt-BR"
                    ]
    }
    
    func createAppendToResponse(appendToResponse: [String]) -> String {
        return appendToResponse.joined(separator: ",")
    }
}
