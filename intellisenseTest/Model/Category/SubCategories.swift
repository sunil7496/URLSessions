
import Foundation

public class SubCategories {
	public var categoryId : String?
	public var name : String?
	public var parentId : String?
	public var age_restricted : String?
	public var android_available : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [SubCategories]
    {
        var models:[SubCategories] = []
        for item in array
        {
            models.append(SubCategories(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		categoryId = dictionary["categoryId"] as? String
		name = dictionary["name"] as? String
		parentId = dictionary["parentId"] as? String
		age_restricted = dictionary["age_restricted"] as? String
		android_available = dictionary["android_available"] as? String
	}

	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.categoryId, forKey: "categoryId")
		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.parentId, forKey: "parentId")
		dictionary.setValue(self.age_restricted, forKey: "age_restricted")
		dictionary.setValue(self.android_available, forKey: "android_available")

		return dictionary
	}

}
