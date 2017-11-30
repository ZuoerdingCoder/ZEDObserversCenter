# ZEDObserversCenter

[![CI Status](http://img.shields.io/travis/李超/ZEDObserversCenter.svg?style=flat)](https://travis-ci.org/李超/ZEDObserversCenter)
[![Version](https://img.shields.io/cocoapods/v/ZEDObserversCenter.svg?style=flat)](http://cocoapods.org/pods/ZEDObserversCenter)
[![License](https://img.shields.io/cocoapods/l/ZEDObserversCenter.svg?style=flat)](http://cocoapods.org/pods/ZEDObserversCenter)
[![Platform](https://img.shields.io/cocoapods/p/ZEDObserversCenter.svg?style=flat)](http://cocoapods.org/pods/ZEDObserversCenter)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ZEDObserversCenter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ZEDObserversCenter"
```

### Usage

```
1. without key
ADD_OBSERVER(protocol, observer)
REMOVE_OBSERVER(protocol, observer)
NOTIFY_OBSERVERS(protocol, func)

2. with a key
ADD_OBSERVER_WITH_KEY(protocol, key, observer)
REMOVE_OBSERVER_WITH_KEY(protocol, key, observer)
NOTIFY_OBSERVERS_WITH_KEY(protocol, key, func)
```

## Author

李超, 964139523@qq.com

## License

ZEDObserversCenter is available under the MIT license. See the LICENSE file for more info.
