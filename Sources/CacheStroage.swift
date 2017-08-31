import Foundation

public typealias completion = (Error?) -> Void

open class CacheStroage {
    
    private let fileManager = FileManager.default
    private let baseUrl: URL
    
    public init(storageName: String) {
        
        do {
            #if os(OSX)
                
                let url = try fileManager.url(for           : .cachesDirectory,
                                              in            : .userDomainMask,
                                              appropriateFor: nil,
                                              create        : true)
                
                baseUrl = url.appendingPathComponent(storageName)
                try createDir(baseUrl.path)
            #endif
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func createDir(_ path: String) throws {
        if !fileManager.fileExists(atPath: path) {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    open func write<T: CacheItem>(name: String, value: T) -> Bool {
        let archivedObject  = NSKeyedArchiver.archivedData(withRootObject: value)
        let path            = baseUrl.appendingPathComponent(name).path
        
        return fileManager.createFile(atPath    : path,
                                      contents  : archivedObject,
                                      attributes: nil)
    }
    
    open func read<T: CacheItem>(name: String) -> (T?, Bool) {
        do {
            let path   = baseUrl.appendingPathComponent(name).path
            let data   = try Data(contentsOf: URL(fileURLWithPath: path))
            let object = NSKeyedUnarchiver.unarchiveObject(with: data) as? T
            
            return (object, (object == nil ? false : true))
        } catch {
            return (nil, false)
        }
    }
    
    open func delete(name: String) -> Bool {
        do {
            let path = baseUrl.appendingPathComponent(name).path
            try fileManager.removeItem(atPath: path)
            return true
        } catch {
            return false
        }
    }
    
    open func all<T: CacheItem>() -> [T] {
        do {
            var items = [T]()
            let _ = try fileManager.contentsOfDirectory(atPath: baseUrl.path).map {
                
                let (v, ok): (T?, Bool) = read(name: $0)
                
                if ok {
                    items.append(v!)
                }
            }
            
            return items
        } catch {
            return [T]()
        }
    }
    
    open func totalSize() -> UInt64 {
        
        do {
            let attr = try fileManager.attributesOfItem(atPath: baseUrl.path) as NSDictionary
            return attr.fileSize()
        } catch {
            return 0
        }
    }
    
}
