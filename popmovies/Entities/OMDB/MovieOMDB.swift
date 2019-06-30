//
//  MovieOMDB.swift
//  popmovies
//
//  Created by Tiago Silva on 21/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import ObjectMapper

class MovieOMDB: BaseModel {
    
    var title : String?
    var year : String?
    var rated : String?
    var released : String?
    var runtime : String?
    var genre : String?
    var director : String?
    var writer : String?
    var actors : String?
    var plot : String?
    var language : String?
    var country : String?
    var awards : String?
    var poster : String?
    var ratings : [Rating]?
    var metascore : String?
    var imdbRating : String?
    var imdbVotes : String?
    var imdbID : String?
    var type : String?
    var dVD : String?
    var boxOffice : String?
    var production : String?
    var website : String?
    var response : String?
    var tomatoURL: String?
    
    var tomatoesRating: Rating? {
        return self.ratings?.first(
            where: { (rating) -> Bool in return rating.source == Rating.TOMATOES_SOURCE_KEY })
    }
    
    var internetMovieDatabaseRating: Rating? {
        return self.ratings?.first(
            where: { (rating) -> Bool in return rating.source == Rating.INTERNET_MOVIE_SOURCE_KEY })
    }
    
    var metacriticRating: Rating? {
        return self.ratings?.first(
            where: { (rating) -> Bool in return rating.source == Rating.METACRITIC_SOURCE_KEY })
    }
    
    override func mapping(map: Map) { 
        
        title <- map["Title"]
        year <- map["Year"]
        rated <- map["Rated"]
        released <- map["Released"]
        runtime <- map["Runtime"]
        genre <- map["Genre"]
        director <- map["Director"]
        writer <- map["Writer"]
        actors <- map["Actors"]
        plot <- map["Plot"]
        language <- map["Language"]
        country <- map["Country"]
        awards <- map["Awards"]
        poster <- map["Poster"]
        ratings <- map["Ratings"]
        metascore <- map["Metascore"]
        imdbRating <- map["imdbRating"]
        imdbVotes <- map["imdbVotes"]
        imdbID <- map["imdbID"]
        type <- map["Type"]
        dVD <- map["DVD"]
        boxOffice <- map["BoxOffice"]
        production <- map["Production"]
        website <- map["Website"]
        response <- map["Response"]
        tomatoURL <- map["tomatoURL"]
    }
    
}
