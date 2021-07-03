
import Foundation
 

public class Category {
	public var status : Int?
	public var message : String?
	public var currency : String?
	public var result : Array<CategoryResult>?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Category]
    {
        var models:[Category] = []
        for item in array
        {
            models.append(Category(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		status = dictionary["status"] as? Int
		message = dictionary["message"] as? String
		currency = dictionary["currency"] as? String
        if (dictionary["result"] != nil) { result = CategoryResult.modelsFromDictionaryArray(array: dictionary["result"] as! NSArray) }
	}

	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.status, forKey: "status")
		dictionary.setValue(self.message, forKey: "message")
		dictionary.setValue(self.currency, forKey: "currency")

		return dictionary
	}

}
