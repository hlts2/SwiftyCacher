import XCTest
@testable import SwiftyCacher

class SwiftyCacherTests: XCTestCase {
    
    func testSetCache() {
        let cache = SwiftyCacher.instance
        
        for i in 0...100 {
            let _ = cache.setWithExpire(key: i.description, value: i, expiration: Date())
        }
    }
    
    func testGetCache() {
        let cache = SwiftyCacher.instance
        
        let (v, ok) = cache.get(key: "0")
        if ok {
            print(v!)
        }
    }

    func testGetAllCache() {
        let cache  = SwiftyCacher.instance
        let values = cache.getAll()
        print(values)
    }

    func testDeleteCache() {
        let cache = SwiftyCacher.instance
        let ok    = cache.delete(key: "0")
        print(ok)
    }

    func testDeleteExpiredCache() {
        let cache = SwiftyCacher.instance
        let _ = cache.deleteExpired()
    }

    func testDeleteIfExpiredCache() {
        let cache = SwiftyCacher.instance
        let _ = cache.deleteIfExpired(key: "9")
    }

    func testDeleteAllCache() {
        let cache = SwiftyCacher.instance
        cache.deleteAll()
    }
    
    static var allTests = [
        ("testSetCache", testSetCache),
        ("testGetCache", testGetCache),
        ("testGetAllCache", testGetAllCache),
        ("testDeleteCache", testDeleteCache),
        ("testDeleteExpiredCache", testDeleteExpiredCache),
        ("testDeleteIfExpiredCache", testDeleteIfExpiredCache),
        ("testDeleteAllCache", testDeleteAllCache)
    ]
}
