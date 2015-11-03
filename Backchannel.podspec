Pod::Spec.new do |s|

  s.name         = "Backchannel"
  s.version      = "0.0.1"
  s.summary      = "A short description of Backchannel."
  s.author       = { "Soroush Khanlou" => "soroush@backchannel.io" }
  s.platform     = :ios, "8.0"
 
  s.source       = { :git => "https://github.com/backchannel/BackchannelSDK-iOS", :tag => s.version.to_s }

  s.source_files  = "Source", "Source/**.{h,m}", "Source/**/*.{h,m}"
  s.resources = "Resources/Images.xcassets"

  s.frameworks = 'Foundation', 'UIKit'
  
end
