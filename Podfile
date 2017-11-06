source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!


target 'Moya+Realm+ObjectMapper'

  pod 'Moya/RxSwift', '~> 10.0.0-beta.1'
  pod 'RxCocoa', '~> 4.0.0-rc.0'
  pod 'RealmSwift', '~> 3.0.0-rc.2'
  pod 'ObjectMapper'
  pod 'ObjectMapper+Realm'


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.0'
    end
  end
end


