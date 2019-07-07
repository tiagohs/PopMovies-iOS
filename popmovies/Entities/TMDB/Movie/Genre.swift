
import Foundation
import ObjectMapper

class Genre : BaseModel {
	var id : Int?
	var name : String?
    var imageName : String?

	override func mapping(map: Map) {
		id <- map["id"]
		name <- map["name"]
        
        if let id = self.id {
            imageName = getImage(id)
        }
        
	}
    
    private func getImage(_ id: Int) -> String? {
        
        for (genreId, genreImageName) in TMDB.GENRES_IMAGES {
            if genreId == id {
                return genreImageName
            }
        }
        
        return nil
    }
    
    static func createGenresFromId(listOfId: [Int]) -> [Genre] {
        var localGenres = TMDB.GENRES_ID
        var finalGenres: [Genre] = []
        
        listOfId.forEach { (genreID) in
            if let value = localGenres[genreID] {
                let genre = Genre()
                
                genre.name = value
                genre.id = genreID
                
                finalGenres.append(genre)
            }
        }
        
        return finalGenres
    }
}

class GenreResult : BaseModel {
    var genres : [Genre]?
    
    override func mapping(map: Map) {
        genres <- map["genres"]
    }
}
