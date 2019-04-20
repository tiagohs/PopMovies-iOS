
import Foundation
import ObjectMapper

class SpokenLanguage : BaseModel {
	var country : String?
	var name : String?

	override func mapping(map: Map) {
		country <- map["iso_639_1"]
		name <- map["name"]
	}

}
