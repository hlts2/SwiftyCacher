import Foundation

open class SwiftyCacher {
    
    private let storage = CacheStroage(storageName: "SwiftyCacher.cache")
    private init() {}
    
    open static let instance = SwiftyCacher()
    
    
    open func get(key: String) -> (value: Any?, Bool) {
        
        let (v, ok) = storage.read(name: key)
        
        if !ok {
            return (nil, false)
        }
        
        if v!.expiration.isVaild() {
            let _ = self.delete(key: key)
            return (nil, false)
        }
        
        return (v!.object, ok)
    }
    
    open func setWithExpire(key: String, value: Any, expiration: Date) {
        
        let _ = storage.write(name: key, value: CacheItem(
            key       : key,
            object    : value,
            expiration: expiration))
    }
    
    open func getAll() -> [String: Any] {
        let dicts = storage.all().reduce([String: Any]()) { (result, item) in
            var result = result
            result[item.key] = item.object
            return result
        }
        
        return dicts
    }
    
    open func delete(key: String) -> Bool {
        return storage.delete(name: key)
    }
    
    open func deleteExpired() -> Int {
        var row: Int = 0
        let _ = storage.all().map { item in
            if item.expiration.isVaild() {
                if storage.delete(name: item.key) {
                    row += 1
                }
            }
        }
        return row
    }
    
    open func deleteIfExpired(key: String) {
        let (v, ok) = storage.read(name: key)
        
        if ok {
            if v!.expiration.isVaild() {
                let _ = storage.delete(name: v!.key)
            }
        }
    }
    
    open func deleteAll() {
        let _ = storage.all().map { v in
            let _ = storage.delete(name: v.key)
        }
    }
    
    open func totalSize() -> UInt64 {
        return storage.totalSize()
    }
    
}
