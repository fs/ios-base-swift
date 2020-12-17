inhibit_all_warnings!
use_frameworks!

def includeCommonPods
    # Analytics
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  
  # Libraries
  pod 'SwiftLint'
  pod 'R.swift'
  pod 'Kingfisher', '~> 5.0'
end

target 'Swift-Base' do
  platform :ios, '13.1'

  includeCommonPods

  target 'Swift-BaseTests' do
    inherit! :search_paths
  end
end

target 'Swift-BaseStaging' do
  platform :ios, '13.1'

  includeCommonPods
end
