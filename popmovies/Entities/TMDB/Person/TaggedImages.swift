
import ObjectMapper

class TaggedImages: BaseModel {
    var results : [TaggedImagesResults]?
    var page : Int?
    var totalResults : Int?
    var id : Int?
    var totalPages : Int?
    
    override func mapping(map: Map) {
        results <- map["results"]
        page <- map["page"]
        totalResults <- map["total_results"]
        id <- map["id"]
        totalPages <- map["total_pages"]
    }
}
