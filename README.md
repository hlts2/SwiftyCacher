# SwiftyCacher
SwiftyCacher is simple cache library for swift

## Example

Fist, you need to import this library

```swift
import SwiftyCacher
```

### Using the cache

```swift

let cache = SwiftyCacher.instance

//Set Cache
cache.setWithExpire(key: "cache_key", value: 1234, expiration: Date())

//Get Cache value
let (v, ok) = cache.get(key: "cache_key")
if ok {
    print(v!) //cache value
}

//Get All Cache value
let values = cache.getAll()
print(values) //["key1": 1234, "key2": 1234]

//Delete Cache
let ok = cache.delete(key: "cache_key")
print(ok) // true or false

//If it expires, delete the cache
cache.deleteExpired()

//If this cache key expires, delete the cache
let ok = cache.deleteIfExpired(key: "cache_key")
print(ok) // true or false

//Delete all Cache
cache.deleteAll()

//Total Caches Size
let size = cache.totalSize()
print(size) // cache size

```

## Requirements
Swift3.0 or latter.

## Installation

HttpSwift is available through [Carthage](https://github.com/Carthage/Carthage) or
[Swift Package Manager](https://github.com/apple/swift-package-manager).

### Carthage

```
github "hlts2/SwiftyCacher"
```

for detail, please follow the [Carthage Instruction](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos)

### Swift Package Manager

```
dependencies: [
    .Package(url: "https://github.com/hlts2/SwiftyCacher.git", majorVersion: 1)
]
```

for detail, please follow the [Swift Package Manager Instruction](https://github.com/apple/swift-package-manager/blob/master/Documentation/Usage.md)
