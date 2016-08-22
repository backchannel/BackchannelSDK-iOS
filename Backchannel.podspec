Pod::Spec.new do |s|

  s.name         = "Backchannel"
  s.version      = "1.1"
  s.license      = 'MIT'
  s.summary      = "Backchannel is a service for bringing discussion to your app’s beta."
  s.author       = { "Soroush Khanlou" => "soroush@backchannel.io" }
  s.social_media_url = "https://twitter.com/backchannelio"
  s.platform     = :ios, "8.0"
  s.homepage     = "https://backchannel.io/"
  s.source       = { :git => "https://github.com/backchannel/BackchannelSDK-iOS.git", :tag => s.version.to_s }

  s.source_files  = "Source", "Source/**.{h,m}", "Source/**/*.{h,m}"
  s.resources = "Resources/Images.xcassets"

  s.frameworks = 'Foundation', 'UIKit'
  
end
