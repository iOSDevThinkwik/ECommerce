# ECommerce#
# Built With
- [XCode](https://developer.apple.com/xcode/)
- [Storyboads](https://developer.apple.com/tutorials/app-dev-training/creating-a-storyboard-app)
- [Swift](https://developer.apple.com/swift/)

## Configuration
- iPhone App
- iOS 13.3+

## Used Libraries (Using Pods)
- [IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager)
- [SDWebImage](https://github.com/SDWebImage/SDWebImage)


## Developing Fenix
### Getting started 
- Clone this project from github. 
- Install pods using ```pod install``` from terminal and wait
- Open ```Ecommerce.xcworkspace``` from XCode

### Project Branches
- UI Design work happens on the ```main``` branch. Pull requests should normally be made to this branch.
- The ```main``` branch holds the most recent release.

### Creating Build
To create build, first steps is to install certificate and provisining profile which are inclued in this repo. 
- Select Provising profile from Signing & Capabilities
- Select Fenix Target -> All iOS Devices (arm64)
- Select Build from Product menu and wait to complete the build
- Find Product folder from Project Navigator, open build with name "Fenix" in Finder
- Archive the Ecommerce.app
- Upload arhive to https://www.diawi.com/ and wait to complete the upload process. 
- Now copy the link from Diawi and share it. 
