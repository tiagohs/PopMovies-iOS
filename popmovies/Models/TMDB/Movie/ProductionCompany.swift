
import ObjectMapper

class ProductionCompany : BaseModel {
	var id : Int?
	var logoPath : String?
	var name : String?
	var originCountry : String?

	override func mapping(map: Map) {
		id              <- map["id"]
		logoPath        <- map["logo_path"]
		name            <- map["name"]
		originCountry   <- map["origin_country"]
	}

}
