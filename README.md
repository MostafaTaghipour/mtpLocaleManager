# mtpLocaleManager

[![CI Status](http://img.shields.io/travis/mostafa.taghipour@ymail.com/mtpLocaleManager.svg?style=flat)](https://travis-ci.org/mostafa.taghipour@ymail.com/mtpLocaleManager)
[![Version](https://img.shields.io/cocoapods/v/mtpLocaleManager.svg?style=flat)](http://cocoapods.org/pods/mtpLocaleManager)
[![License](https://img.shields.io/cocoapods/l/mtpLocaleManager.svg?style=flat)](http://cocoapods.org/pods/mtpLocaleManager)
[![Platform](https://img.shields.io/cocoapods/p/mtpLocaleManager.svg?style=flat)](http://cocoapods.org/pods/mtpLocaleManager)

## [Android version is here](https://github.com/MostafaTaghipour/LocaleManager)

mtpLocaleManger is a locale manager for iOS:

- Change locale at runtime
- Supports multiple language
- Change locale according to system locale
- Easy to use


![multi-language app](https://raw.githubusercontent.com/mtpLocaleManager/mtpFontManager/master/screenshots/1.gif)


## Requirements
- iOS 8.0+
- Xcode 9+



## Installation

mtpLocaleManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'mtpLocaleManager'
```


## Usage

1. Add as many languages as you need to the project
we have the Base language resource structure by default. Let’s add new language support.
Select your project file in Project Navigator, and select your project in the project and targets list. Open Info tab, and click “+” button under Localizations section. Then choose a language you want to support from the dropdown list shown.
<img src="https://raw.githubusercontent.com/MostafaTaghipour/mtpLocaleManager/master/screenshots/2.png" width="300" title="add new language">
XCode opens a dialog showing resources to be added for the new language. Pressing the Finish button will generate these files under the new language project folder
<img src="https://raw.githubusercontent.com/MostafaTaghipour/mtpLocaleManager/master/screenshots/3.png" width="300" title="localize app">

2. Any time you need to change the locale of the application using the following code
```swift
LocaleManager.shared.currentLocale  = Locale(identifier: /* your desired language*/ "fa") 
```

thats it, now run your app and enjoy it


### Notification
There is a notification that fired when locale did changed
```swift
override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(localeDidChanged(notification:)), name: NSNotification.Name.LocaleDidChange, object: nil)
}


@objc func localeDidChanged(notification:Notification)  {
    if let locale=notification.object as? String{
        print(locale)
    }
}

```


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Author

Mostafa Taghipour, mostafa@taghipour.me

## License

mtpThemeManager is available under the MIT license. See the LICENSE file for more info.
