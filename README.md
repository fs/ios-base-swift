[![Build Status](https://travis-ci.org/fs/ios-base-swift.svg?branch=master)](https://travis-ci.org/fs/ios-base-swift)

# ios-base-swift

iOS swift template application.

## Get started

To setup project follow a few simple steps:
 1. [Download][1].
 2. [Rename project][2].
 3. [Configure mogenerator][3].
 4. [Configure CocoaPods][4].
 5. [Configure Fabric/Crashlytics][5].
 6. [Edit README.md][6].

### Download
Download prject as `zip` file.

### Rename project
run `rename-project.command script`

### Configure CocoaPods
* Find Podfile in project.
* Uncomment, add or remove pods.
* Then run in terminal:

```sh
pod install
```

### Configure Fabric/Crashlytics
* [Download Fabric desktop application][13]
* Check **Bundle ID** in project build settings for all schemes.
* Create new organization in Fabric/Crashlytics.
* Add applications to this organization for all schemes.
* [!] Do not forget change **Run Script** in settings of the project.

### Configure TestFlight
* Go to [iTunes Connect][20]
* Create applications for Staging and Release

### Edit README.md
* Edit `README.md`.

### CI

#### Creating certificates and provisioning profiles
* Go to [Developer Center][14]. 
* Choose ```Certificates -> All``` and create Developer and Distribution certificates. 
* Choose ```Identifiers -> App IDs``` and create new two bundles for Staging and Release.
* Choose ```Devices -> All``` and add all devices for testing.
* Choose ```Provisioning Profiles -> All``` and create 6 provisioning profiles for Staging ```Debug Staging```, ```Release Staging```, ```AppStore Staging``` and for Release ```Debug```, ```Release```,  ```AppStore```.
* Download the 2 certificates and the 6 provisioning profiles.
* Copy the files to ```/Certs``` path.
* Encrypting the files via ```openssl aes-256-cbc -k "YOUR_ENCRYPTION_SECRET" -in Certs/XXX.ext -out Certs/XXX.ext.enc -a```

#### Setting fastlane scripts

* We use [bundler][16] for third-party gems. Set it like [here][17].
* Find AppFile in the project and set ```team_id``` from developer program.
* Find Deliverfile in the project and set ```username``` like apple id. 
* Open the Terminal, write ```fastlane fastlane-credentials add --username YOUR_APPLE_ID``` and save your password to [CredentialManager][18]. It need that you can send new builds locally without input of the password everytime.
* Find Fastfile in the project and set:
- ```fastlane_version```, ```info_plist_path``` - required settings of the project.
- ```CRASHLYTICS_GROUPS``` - testers aliases of Fabric/Crashlytics. Example: "group1, group2".
- ```BUNDLE_ID_APPSTORE```, ```BUNDLE_ID_APPSTORE_STAGING``` - for TestFlight. 
- Check ```SCHEME_STAGING```, ```SCHEME_APPSTORE```, ```SCHEME_APPSTORE_STAGING``` - shared schemes.
* [More info][15]

#### Setting [Travis][19] 

Add on the CI environment variables:
* ```APP_NAME``` - your the name of the app (can be open)
* ```ENCRYPTION_SECRET``` - secret key of certificates and provisioning profiles (must be private)
* ```DEVELOP_BRANCH``` and ```DEVELOP_LANE``` - setting developer branch and fastlane name (can be open) 
* ```RELEASE_BRANCH``` and ```RELEASE_LANE``` - setting release branch and fastlane name (can be open)
* ```FASTLANE_USER``` and ```FASTLANE_PASSWORD``` - apple id for deploying to testflight (must be private)
* ```CRASHLYTICS_TOKEN```, ```CRASHLYTICS_SECRET``` - API key and Build secret of Fabric for deploying to Fabric/Crashlytics (must be private)

## License
ios-base-swift is released under the MIT license. See [LICENSE][7] for details.

## Credits

iOS Base is maintained by [Nikita Fomin][8], [Sergey Nikolaev][9] and [Vladimir Goncharov][10].
It was written by [Flatstack][11] with the help of our
[contributors][12].

[<img src="http://www.flatstack.com/logo.svg" width="100"/>][11]

[1]:	#download
[2]:	#rename-project
[3]:	#configure-mogenerator
[4]:	#configure-cocoapods
[5]:	#configure-fabric-crashlytics
[6]:	#edit-readme-md
[7]:	LICENSE
[8]:	http://github.com/nikitafomin
[9]:	https://github.com/NikolaevSergey
[10]:	https://github.com/VladimirGoncharov
[11]:	http://www.flatstack.com
[12]:	https://github.com/fs/ios-base-swift/graphs/contributors
[13]:	https://get.fabric.io
[14]:	https://developer.apple.com/
[15]:	https://docs.fastlane.tools/getting-started/ios/setup/
[16]:	https://bundler.io/
[17]:	https://docs.fastlane.tools/getting-started/ios/setup/#use-a-gemfile
[18]:	https://docs.fastlane.tools/advanced/#adding-credentials
[19]:	https://travis-ci.org
[20]:	https://itunesconnect.apple.com
