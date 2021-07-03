
import Foundation

public class CategoryResult {
	public var categoryId : String?
	public var name : String?
	public var subCategories : Array<SubCategories>?

    public class func modelsFromDictionaryArray(array:NSArray) -> [CategoryResult]
    {
        var models:[CategoryResult] = []
        for item in array
        {
            models.append(CategoryResult(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		categoryId = dictionary["categoryId"] as? String
		name = dictionary["name"] as? String
        if (dictionary["subCategories"] != nil) { subCategories = SubCategories.modelsFromDictionaryArray(array: dictionary["subCategories"] as! NSArray) }
	}

	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.categoryId, forKey: "categoryId")
		dictionary.setValue(self.name, forKey: "name")

		return dictionary
	}

}
