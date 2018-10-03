# Where is my Rick?
**Where is my Rick?** is demo project for article and talk about UITesting tools available for iOS development.

### Run KIF, EarlGrey, XCUITests
- You should be able to run this tools just by selecting coresponding schema in Xcode

### Run Appium
- Download Appium desktop app  
  https://github.com/appium/appium-desktop/releases
- Run `bundler install` in `Appium` folder
- Start server in Appium app
- Optional: Run `Appium` schema in Xcode. It will copy new version of app to `Appium` folder
- Run `bundler exec cucumber` in `Appium` folder

### Run calabash
- Run `bundler install` in `Calabash` folder
- Run `bundler exec cucumber` in `Calabash` folder

Optional to generate new version of app to tests:
- Build `Calabash` schema in Xcode
- Copy `Calabash.app` from `Products` to `Calabash` folder

#### Optional steps:
- Install `CocoaPods` by:  
  `gem install cocoapods`
- Install `Bundler` by:  
  `gem install bundler`
- Install EarlGrey gem by:  
  `gem install earlgrey -v 1.14.0`  
**EarlGrey** use this gem as part of `pod install`  

> [Never instal gems with sudo!](https://github.com/calabash/calabash-ios/wiki/Best-Practice%3A--Never-install-gems-with-sudo)  
> Instead we recommend to use [RVM](https://rvm.io)

### Contacts
In case of any questions / problems feel free to open issue in this repo.

### License
Example is available under Apache 2 license. See the `LICENSE` file for more info.