
import Foundation
import ObjectMapper

class SpokenLanguage : BaseModel {
	var iso639_1 : String?
	var name : String?

	override func mapping(map: Map) {
		iso639_1 <- map["iso_639_1"]
		name <- map["name"]
	}

}
