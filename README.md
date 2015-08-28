# ios-base-swift

iOS swift template application.

## Get started

To setup project follow a few simple steps:
 1. [Download](#download).
 2. [Rename project](#rename-project).
 3. [Configure mogenerator](#configure-mogenerator).
 4. [Configure CocoaPods](#configure-cocoapods).
 5. [Configure Fabrick/Crashlytics](#configure-fabric-crashlytics).
 6. [Edit README.md](#edit-readme-md).
 7. [Commit and push to repository](#made-initial-commit-and-push-to-remote-repository).

### Download
* Download prject as ```zip``` file.

### Rename project
To rename project you should:

#### Change project name:
* In the Project Navigator on the left side, click twice slowly and the Project file name will be editable. Type the new name. A sheet will appear with a warning and will list all the items Xcode believes it should change.
* Accept the changes.

#### Remove mentions in code:
* Open search tab in the Project Navigator on the left side of Xcode.
* Search ```swift-base``` in project.
* Replace any occurrence of the ios-base name with the new project name.

#### Change folders names:
* Go to the project directory and rename folders ```Swift-Base```, ```Swift-BaseTests```.
* Rename ```Swift-BaseTests.swift``` in folder for test classes.

#### Change .xcodeproj file:
* Right click the project bundle ```.xcodeproj``` file and select “Show Package Contents” from the context menu. Open the ```.pbxproj``` file with any text editor.
* Search and replace any occurrence of the ```swift-base``` with the new project name.
* Save the file.

#### Change bundle id:
* Change bundle id for all schemes in project build settings.

#### Rename workspace:
* Simple rename ```Swift-Base.xcworkspace``` with new project name.

### Configure mogenerator
* Go to Build Rules.
* Change path to script in  ```Data model files using Script```.
* Change path to script in  ```Data model version files using Script```.

### Configure CocoaPods
* Finde Podfile in project.
* Uncomment, add or remove pods.

```sh
platform :ios, '8.0'
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

pod 'FSHelpers+Swift', '~> 1.1'
pod 'AFNetworking', '~> 2.5'
#pod 'SDWebImage', '~> 3.7'
#pod 'NSDate-Extensions'
#pod 'MagicalRecord'
#pod 'Reachability'
#pod 'SVProgressHUD', '~> 1.0'
#pod 'SSKeychain'
#pod 'NSData+Base64'
#pod 'MKStoreKit'
#pod 'NSDate-Extensions'

target 'Swift-BaseTests', :exclusive => true do
pod 'KIF', '~> 3.2', :configurations => ['Debug', 'Debug Staging']
end
```

* Then run in terminal:

```sh
pod install
```

### Configure Fabric/Crashlytics
* Check bundle id in project build settings for all schemes.
* Create organization in Fabric/Crashlytics.
* Add applications to this organization for all schemes.

### Edit README.md
* Edit ```README.md```.

### Made initial commit and push to remote repository
```sh
cd Path/To/Project
git init
git add --all
git commit -m "Initial commit"
git remote add origin git@github.com:fs/some-git-repository.git
git push origin master 
```

## Credits

iOS Base is maintained by [Nikita Fomin](http://github.com/nikitafomin), [Sergey Nikolaev](https://github.com/NikolaevSergey) and [Vladimir Goncharov](https://github.com/VladimirGoncharov).
It was written by [Flatstack](http://www.flatstack.com) with the help of our
[contributors](http://github.com/fs/ios-base/contributors).


[![Flatstack](https://avatars0.githubusercontent.com/u/15136?v=2&s=200)](http://www.flatstack.com)