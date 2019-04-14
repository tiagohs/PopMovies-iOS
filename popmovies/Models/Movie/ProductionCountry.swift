
import Foundation
import ObjectMapper

class ProductionCountry : BaseModel {
	var iso3166_1 : String?
	var name : String?

	override func mapping(map: Map) {
		iso3166_1 <- map["iso_3166_1"]
		name <- map["name"]
	}

}
