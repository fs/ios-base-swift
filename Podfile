platform :ios, '8.2'
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!


abstract_target 'Abstract' do
    pod 'FSHelpers+Swift', :git => 'https://github.com/fs/FSHelper.git'
    
    # Analytics
    pod 'Fabric'
    pod 'Crashlytics'
    
    # Libraries
    pod 'AFNetworking'
    pod 'MagicalRecord'
    
    target 'Swift-Base' do
    end
    
    target 'Swift-BaseTests' do
    end
    
    target 'Swift-BaseUITests' do
    end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
            config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
        end
    end
end

# Helpers

#pod 'SDWebImage'
#pod 'NSDate-Extensions'
#pod 'Reachability'
#pod 'SVProgressHUD'
#pod 'SSKeychain'
#pod 'MKStoreKit'
