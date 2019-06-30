
import Foundation
import ObjectMapper

class ProductionCountry : BaseModel {
	var country : String?
	var name : String?

	override func mapping(map: Map) {
		country <- map["iso_3166_1"]
		name <- map["name"]
	}

}
