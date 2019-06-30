//
//  Movie.swift
//  popmovies
//
//  Created by Tiago Silva on 14/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie: BaseModel, Hashable {
    
    var id: Int?
    var adult: Bool?
    var backdropPath: String?
    var belongsToCollection: String?
    var budget: Int?
    var homepage: String?
    var imdbID, originalLanguage, originalTitle, overview: String?
    var popularity: Double?
    var posterPath: String?
    var revenue, runtime: Int?
    var status, tagline, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    var releaseDate: Date?
    
    var genres: [Genre]?
    var productionCompanies: [ProductionCompany]?
    var productionCountries: [ProductionCountry]?
    var spokenLanguages: [SpokenLanguage]?
    
    // Append To Reponse
    var alternativeTitles: [AlternativeTitle]?
    var credits: MediaCreditList?
    var images: Images?
    var keywords: [KeywordResults]?
    var releases: [Release]?
    var videos: VideoResult?
    var translations: [TranslationResults]?
    var similiarMovies: Results<Movie>?
    var reviews: [Review]?
    
    var allImages: [Image] = []
    
    override func mapping(map: Map) {
        id                      <-  map["id"]
        adult                   <-  map["adult"]
        backdropPath            <-  map["backdrop_path"]
        belongsToCollection     <-  map["belongs_to_collection"]
        budget                  <-  map["budget"]
        homepage                <-  map["homepage"]
        imdbID                  <-  map["imdb_id"]
        originalLanguage        <-  map["original_language"]
        originalTitle           <-  map["original_title"]
        overview                <-  map["overview"]
        popularity              <-  map["popularity"]
        posterPath              <-  map["poster_path"]
        revenue                 <-  map["revenue"]
        runtime                 <-  map["runtime"]
        status                  <-  map["status"]
        tagline                 <-  map["tagline"]
        title                   <-  map["title"]
        video                   <-  map["video"]
        voteAverage             <-  map["vote_average"]
        voteCount               <-  map["vote_count"]
        releaseDate             <-  (map["release_date"], DateFormatTransform("yyyy-MM-dd"))
        genres                  <-  map["genres"]
        
        productionCompanies     <-  map["production_companies"]
        productionCountries     <-  map["production_countries"]
        spokenLanguages         <-  map["spoken_languages"]
        
        alternativeTitles       <- map["alternative_titles"]
        credits                 <- map["credits"]
        images                  <- map["images"]
        keywords                <- map["keywords"]
        releases                <- map["releases"]
        videos                  <- map["videos"]
        translations            <- map["translations"]
        similiarMovies          <- map["similar_movies"]
        reviews                 <- map["reviews"]
        
        allImages               = mergeImages()
    }
    
    private func mergeImages() -> [Image] {
        let posters = self.images?.backdrops ?? []
        let backdrop = self.images?.posters ?? []
        
        if (posters.count > 3 && backdrop.count > 3) {
            return Array(backdrop[0..<3]) + Array(posters[0..<3])
        }
        
        return Array(Set(backdrop + posters))
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return (lhs.id == rhs.id)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
