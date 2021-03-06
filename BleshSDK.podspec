Pod::Spec.new do |s|
    s.name             = "BleshSDK"
    s.version          = "5.2.7"
    s.summary       = "Blesh iOS SDK"
    s.homepage     = "https://github.com/bleshcom/Blesh-iOS-SDK"
    s.author           = { "Blesh Technology Team" => "technology@blesh.com" }
    s.source           = { :git => "https://github.com/bleshcom/Blesh-iOS-SDK.git", :tag => s.version.to_s }
  
    s.platform     = :ios, 9.0
    s.requires_arc = true
  
    s.vendored_frameworks = 'BleshSDK.xcframework'
    s.frameworks = 'Foundation', 'UIKit', 'CoreLocation', 'CoreTelephony'

    s.license      = {
        :type => 'Copyright',
        :text => <<-LICENSE
        Copyright 2013 - 2021 Blesh, Inc. All rights reserved.
        LICENSE
    }
  end
