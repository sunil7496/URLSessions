
import Foundation

public class SubCategory {
	public var status : Int?
	public var message : String?
	public var currency : String?
	public var result : Array<SubCategoryResult>?

    public class func modelsFromDictionaryArray(array:NSArray) -> [SubCategory]
    {
        var models:[SubCategory] = []
        for item in array
        {
            models.append(SubCategory(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		status = dictionary["status"] as? Int
		message = dictionary["message"] as? String
		currency = dictionary["currency"] as? String
        if (dictionary["result"] != nil) { result = SubCategoryResult.modelsFromDictionaryArray(array: dictionary["result"] as! NSArray) }
	}

	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.status, forKey: "status")
		dictionary.setValue(self.message, forKey: "message")
		dictionary.setValue(self.currency, forKey: "currency")

		return dictionary
	}

}
