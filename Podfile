platform :ios, '11.0'
inhibit_all_warnings!

target 'Swift-Base' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Analytics
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  
  # Libraries
  pod 'Alamofire'
  pod 'SwiftLint'
  pod 'Moya'
  pod 'PromiseKit'
  pod 'R.swift'
  pod 'Kingfisher', '~> 5.0'

  target 'Swift-BaseTests' do
    inherit! :search_paths
    # Pods for testing
  end
end
