
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
    
}

class GenreResult : BaseModel {
    var genres : [Genre]?
    
    override func mapping(map: Map) {
        genres <- map["genres"]
    }
}
