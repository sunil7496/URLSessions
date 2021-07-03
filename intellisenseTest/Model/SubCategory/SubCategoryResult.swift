
import Foundation

public class SubCategoryResult {
	public var itemId : String?
	public var storeId : String?
	public var serviceTax : String?
	public var is_delivery_avail : Int?
	public var deliveryFee : String?
	public var minimumOrder : String?
	public var categoryId : String?
	public var name : String?
	public var description : String?
	public var regularPrice : String?
	public var offerPrice : String?
	public var tax_name : String?
	public var rate : String?
	public var subCatId : String?
	public var featuredImage : String?
	public var manage_stock : String?
	public var stock : String?
	public var createdOn : String?
	public var updatedAt : String?
	public var averageRating : String?
	public var total_reviews : Int?
	public var tax : String?
	public var isFavItem : Int?
	public var moreitems : Array<String>?
	public var extra_items : Array<String>?
	public var gallery : Array<String>?
	public var allergy : Array<String>?
	public var variations : Array<String>?

    public class func modelsFromDictionaryArray(array:NSArray) -> [SubCategoryResult]
    {
        var models:[SubCategoryResult] = []
        for item in array
        {
            models.append(SubCategoryResult(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		itemId = dictionary["itemId"] as? String
		storeId = dictionary["storeId"] as? String
		serviceTax = dictionary["serviceTax"] as? String
		is_delivery_avail = dictionary["is_delivery_avail"] as? Int
		deliveryFee = dictionary["deliveryFee"] as? String
		minimumOrder = dictionary["minimumOrder"] as? String
		categoryId = dictionary["categoryId"] as? String
		name = dictionary["name"] as? String
		description = dictionary["description"] as? String
		regularPrice = dictionary["regularPrice"] as? String
		offerPrice = dictionary["offerPrice"] as? String
		tax_name = dictionary["tax_name"] as? String
		rate = dictionary["rate"] as? String
		subCatId = dictionary["subCatId"] as? String
		featuredImage = dictionary["featuredImage"] as? String
		manage_stock = dictionary["manage_stock"] as? String
		stock = dictionary["stock"] as? String
		createdOn = dictionary["createdOn"] as? String
		updatedAt = dictionary["updatedAt"] as? String
		averageRating = dictionary["AverageRating"] as? String
		total_reviews = dictionary["total_reviews"] as? Int
		tax = dictionary["tax"] as? String
		isFavItem = dictionary["isFavItem"] as? Int
//		if (dictionary["moreitems"] != nil) { moreitems = Moreitems.modelsFromDictionaryArray(dictionary["moreitems"] as! NSArray) }
//		if (dictionary["extra_items"] != nil) { extra_items = Extra_items.modelsFromDictionaryArray(dictionary["extra_items"] as! NSArray) }
//		if (dictionary["gallery"] != nil) { gallery = Gallery.modelsFromDictionaryArray(dictionary["gallery"] as! NSArray) }
//		if (dictionary["allergy"] != nil) { allergy = Allergy.modelsFromDictionaryArray(dictionary["allergy"] as! NSArray) }
//		if (dictionary["variations"] != nil) { variations = Variations.modelsFromDictionaryArray(dictionary["variations"] as! NSArray) }
	}

	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.itemId, forKey: "itemId")
		dictionary.setValue(self.storeId, forKey: "storeId")
		dictionary.setValue(self.serviceTax, forKey: "serviceTax")
		dictionary.setValue(self.is_delivery_avail, forKey: "is_delivery_avail")
		dictionary.setValue(self.deliveryFee, forKey: "deliveryFee")
		dictionary.setValue(self.minimumOrder, forKey: "minimumOrder")
		dictionary.setValue(self.categoryId, forKey: "categoryId")
		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.description, forKey: "description")
		dictionary.setValue(self.regularPrice, forKey: "regularPrice")
		dictionary.setValue(self.offerPrice, forKey: "offerPrice")
		dictionary.setValue(self.tax_name, forKey: "tax_name")
		dictionary.setValue(self.rate, forKey: "rate")
		dictionary.setValue(self.subCatId, forKey: "subCatId")
		dictionary.setValue(self.featuredImage, forKey: "featuredImage")
		dictionary.setValue(self.manage_stock, forKey: "manage_stock")
		dictionary.setValue(self.stock, forKey: "stock")
		dictionary.setValue(self.createdOn, forKey: "createdOn")
		dictionary.setValue(self.updatedAt, forKey: "updatedAt")
		dictionary.setValue(self.averageRating, forKey: "AverageRating")
		dictionary.setValue(self.total_reviews, forKey: "total_reviews")
		dictionary.setValue(self.tax, forKey: "tax")
		dictionary.setValue(self.isFavItem, forKey: "isFavItem")

		return dictionary
	}

}
