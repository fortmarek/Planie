source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

# TODO Change branch to version once released.

def shared_pods
    pod 'Reactant/All-iOS'
    pod 'Reactant/ActivityIndicator'
    pod 'ReactantUI'
    pod 'ReactantLiveUI', :configuration => 'Debug'
    pod 'Firebase', :subspecs => ['Auth', 'Crash', 'Database']
    pod 'SwiftDate'
    pod 'Fetcher'
    pod 'Fetcher/RxFetcher'
    pod 'DataMapper'
    pod 'IQKeyboardManagerSwift'
    pod 'JGProgressHUD'
    pod 'SwiftKeychainWrapper'
    pod 'SwipeBack'
    pod 'AFImageHelper'
    pod 'SwiftGen'
    pod 'SuperDelegate'
    pod 'SCLAlertView'
    pod 'Fabric'
    pod 'Crashlytics'

end

def test_pods
    pod 'Quick', '~> 1.1.0'
    pod 'Nimble', '~> 7.0'
    pod 'RxBlocking', '~> 4.0'
    pod 'RxNimble', '~> 4.0.0'
end

target 'TravelPlanner' do
    shared_pods
end

target 'TravelPlannerTests' do
    shared_pods
    test_pods
end

target 'TravelPlannerUITests' do
    shared_pods
    test_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
        if target.name == 'SCLAlertView'
            config.build_settings['SWIFT_VERSION'] = '3.2'
        end
    end
  end
end

