//
//  Person.swift
//  popmovies
//
//  Created by Tiago Silva on 19/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import ObjectMapper

class Person: BaseModel {
    var id : Int?
    var birthday : Date?
    var knownForDepartment : String?
    var placeOfBirth : String?
    var homepage : String?
    var profilePath : String?
    var imdbId : String?
    var deathday : String?
    var name : String?
    var alsoKnownAs : [String]?
    var biography : String?
    var adult : Bool?
    var gender : Int?
    var popularity : Double?
    
    // Append To Reponse
    var images : Images?
    var externalIds : ExternalIds?
    var movieCredits : MovieCredits?
    var taggedImages : TaggedImages?
    
    //Custom
    var allMovieCredits : [Movie] = []
    var allImages : [Image] = []
    
    override func mapping(map: Map) {
        birthday                <- (map["birthday"], DateFormatTransform("yyyy-MM-dd"))
        knownForDepartment      <- map["known_for_department"]
        id                      <- map["id"]
        placeOfBirth            <- map["place_of_birth"]
        homepage                <- map["homepage"]
        profilePath             <- map["profile_path"]
        imdbId                  <- map["imdb_id"]
        deathday                <- map["deathday"]
        images                  <- map["images"]
        externalIds             <- map["external_ids"]
        name                    <- map["name"]
        alsoKnownAs             <- map["also_known_as"]
        biography               <- map["biography"]
        movieCredits            <- map["movie_credits"]
        adult                   <- map["adult"]
        gender                  <- map["gender"]
        popularity              <- map["popularity"]
        taggedImages            <- map["tagged_images"]
        
        allImages = mergeImages()
        allMovieCredits = mergeMovies()
    }
    
    func mergeMovies() -> [Movie] {
        let castCredits = self.movieCredits?.cast?.map({ (creditCast) -> Movie in
            let movie = Movie()
            
            movie.id = creditCast.id
            movie.title = creditCast.title
            movie.posterPath = creditCast.posterPath
            movie.backdropPath = creditCast.backdropPath
            movie.releaseDate = creditCast.releaseDate
            
            return movie
        }) ?? []
        let crewCredits = self.movieCredits?.crew?.map({ (creditCrew) -> Movie in
            let movie = Movie()
            
            movie.id = creditCrew.id
            movie.title = creditCrew.title
            movie.posterPath = creditCrew.posterPath
            movie.backdropPath = creditCrew.backdropPath
            movie.releaseDate = creditCrew.releaseDate
            
            return movie
        }) ?? []
        
        return Array(Set(castCredits + crewCredits))
    }
    
    func mergeImages() -> [Image] {
        let taggedImages = self.taggedImages?.results?.map({ (taggedImagesResults) -> Image in
            let image = Image()
            image.filePath = taggedImagesResults.filePath
            
            return image
        }) ?? []
        let profileImages = images?.profiles ?? []
        
        return Array(Set(taggedImages + profileImages))
    }
}
