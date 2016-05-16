# ios-base-swift

iOS swift template application.

## Get started

To setup project follow a few simple steps:
 1. [Download][1].
 2. [Rename project][2].
 3. [Configure mogenerator][3].
 4. [Configure CocoaPods][4].
 5. [Configure Fabrick/Crashlytics][5].
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
* Check **Bundle ID** in project build settings for all schemes.
* Create new organization in Fabric/Crashlytics.
* Add applications to this organization for all schemes.
* Do not forget change **Run Script** in settings of the project.

### Edit README.md
* Edit `README.md`.

## License
ios-base-swift is released under the MIT license. See [LICENSE][7] for details.

## Credits

iOS Base is maintained by [Nikita Fomin][8], [Sergey Nikolaev][9] and [Vladimir Goncharov][10].
It was written by [Flatstack][11] with the help of our
[contributors][12].

[<img src="http://www.flatstack.com/logo.svg" width="100"/>][13]

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
[12]:	http://github.com/fs/ios-base/contributors
[13]:	http://www.flatstack.com