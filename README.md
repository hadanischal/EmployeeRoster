# EmployeeRoster
## Requirements:
* iOS 13.0+
* Xcode 11.6
* Swift 5.2

## Objective:
This sample app to demonstrate some aspect of clean architecture using  MVVM pattern, RxSwift, dependency injection, **SOLID principles** , loose coupling, **unit testing**, Dark mode support and some of the best practices used in modern iOS programming using `Swift`.

## App Goal:
* This project was intended to work as a Employee Roster demo projects for iOS using Swift. 
* The demo uses the [Employee Roster API](https://gist.githubusercontent.com/hadanischal/) which returns information in a JSON format.
* Use of UITableViewController to display Employee roster list information.
* Implemented Unit test for business logic.
* Use of **RxSwift** for Reactive programming.

## Installation

- Xcode **11.6**(required)
- Clean `/DerivedData` folder if any
- Run the pod install `pod install`
- Run Cuckoo script to Mock your Swift objects `./Cuckoo-GeneratedMocks.sh`
- Run SwiftGen script to generator Swift code for assets, Localizable.strings etc `./generate-swiftgen.sh`
- Then clean and build the project in Xcode

## 3rd Party Libraries
 - **`RxSwift`** - [ReactiveX/RxSwift](https://github.com/ReactiveX/RxSwift) is  used to make `Reactive` binding of API call and response
 - **`Kingfisher`** - [onevcat/Kingfisher](https://github.com/onevcat/Kingfisher) for downloading and caching images from the web.
 - **`RealmSwift`** - [realm/realm-cocoa](https://github.com/realm/realm-cocoa/tree/master/RealmSwift) Realm is a mobile database: a replacement for Core Data & SQLite.
 - **`Alamofire`** - [Alamofire/Alamofire](https://github.com/Alamofire/Alamofire) Elegant HTTP Networking in Swift.
 - **`KeychainAccess`** - [kishikawakatsumi/KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess) Simple Swift wrapper for Keychain that works on iOS, watchOS, tvOS and macOS.
 - **`PKHUD`** - [pkluz/PKHUD](https://github.com/pkluz/PKHUD) to show loading activity indicator
 - **`SwiftRichString`** - [malcommac/SwiftRichString](https://github.com/malcommac/SwiftRichString) Elegant, easy and Swifty way to create Attributed Strings
 - **`SwiftLint`** - [realm/SwiftLint](https://github.com/realm/SwiftLint) A tool to enforce Swift style and conventions. 
 - **`SwiftGen`** - [SwiftGen/SwiftGen](https://github.com/SwiftGen/SwiftGen) swift code generator for your assets, storyboards, Localizable.strings. 
 - **`CocoaLumberjack`** - [CocoaLumberjack/CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack) A fast & simple, yet powerful & flexible logging framework for Mac and iOS.
 - **`OHHTTPStubs`** - [AliSoftware/OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs) stub your network requests 
 - **`Quick`** - [Quick/Quick](https://github.com/Quick/Quick) is testing framework in swift
 - **`Nimble`** - [Quick/Nimble](https://github.com/Quick/Nimble) is Matcher Framework for Swift to pair with Quick
 - **`Cuckoo`** - [Brightify/Cuckoo](https://github.com/Brightify/Cuckoo) is tasty mocking framework for unit tests in swift

## Technical notes:
- MVVM - My preferred architecture.
    - MVVM stands for “Model View ViewModel”
    - It’s a software architecture often used by Apple developers to replace MVC. Model-View-ViewModel (MVVM) is a structural design pattern that separates objects into three distinct groups:
- Models hold application data. They’re usually structs or simple classes.
- Views display visual elements and controls on the screen. They’re typically - subclasses of UIView.
- View models transform model information into values that can be displayed on a view. They’re usually classes, so they can be passed around as references.

![Alt text](/README/MVVM.jpeg?raw=true)

## Screenshot:
![Screen Shot 1](/README/screenshot1.png?raw=true)


 #### App Demo


 ![](/README/demo.gif "")
