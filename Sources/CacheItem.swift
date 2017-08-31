import Foundation

open class CacheItem: NSObject, NSCoding {
    open let key        : String!
    open var object     : Any!
    open var expiration : Date!
    
    init(key: String, object: Any, expiration: Date) {
        self.key        = key
        self.object     = object
        self.expiration = expiration
    }
    
    //Deselialize
    required public init?(coder aDecoder: NSCoder) {
        guard let key        = aDecoder.decodeObject(forKey: "key") as? String,
            let object     = aDecoder.decodeObject(forKey: "object"),
            let expiration = aDecoder.decodeObject(forKey: "expiration") as? Date else {
                return nil
        }
        
        self.key        = key
        self.object     = object as Any
        self.expiration = expiration
        super.init()
    }
    
    //Selialize
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.key, forKey: "key")
        aCoder.encode(self.object, forKey: "object")
        aCoder.encode(self.expiration, forKey: "expiration")
    }
    
}

public extension Date {
    public  func isVaild() -> Bool {
        return Date() > self
    }
}
