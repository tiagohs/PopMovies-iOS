
import Foundation
import ObjectMapper

class Genre : BaseModel {
	var id : Int?
	var name : String?

	override func mapping(map: Map) {
		id <- map["id"]
		name <- map["name"]
	}

}
