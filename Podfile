inhibit_all_warnings!
use_frameworks!

def includeCommonPods
    # Analytics
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  
  # Libraries
  pod 'Alamofire', '4.9.1'
  pod 'SwiftLint'
  pod 'PromiseKit'
  pod 'R.swift'
  pod 'Kingfisher', '~> 5.0'
end

target 'Swift-Base' do
  platform :ios, '11.0'

  includeCommonPods

  target 'Swift-BaseTests' do
    inherit! :search_paths
  end
end

target 'Swift-BaseStaging' do
  platform :ios, '11.0'

  includeCommonPods
end
