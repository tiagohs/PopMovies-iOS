//
//  URLUtils.swift
//  popmovies
//
//  Created by Tiago Silva on 28/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class URLUtils {
    
    static func formatIMDBUrl(imdbId: String?) -> String? {
        guard let id = imdbId else { return nil }
        
        return "\(Constants.URL.IMDB_URL)title/\(id)"
    }
    
    static func formatWikiUrl(wikiSearchTerm: String?) -> String? {
        guard let search = wikiSearchTerm else { return nil }
        
        return "\(Constants.URL.WIKI_URL)index.php?search=\(search)"
    }
    
    static func formatYoutubeUrl(videoId: String?) -> String? {
        guard let id = videoId else { return nil }
        
        return "https://i.ytimg.com/vi/\(id)/hqdefault.jpg"
    }
}
