Pod::Spec.new do |s|
    s.name                = "BleshSDK"
    s.version             = "5.5.0"
    s.summary             = "Blesh iOS SDK"
    s.homepage            = "https://blesh.com"
    s.author              = { "Blesh Technology Team" => "technology@blesh.com" }

    s.source              = { :git => "https://github.com/bleshcom/Blesh-iOS-SDK.git", :tag => s.version.to_s }
    s.source_files        =  'BleshSDK.xcframework/**/BleshSDK.framework/Headers/*.h'
  
    s.platform            = :ios, 11.0
    s.requires_arc        = true

    s.vendored_frameworks = "BleshSDK.xcframework"
    s.frameworks          = 'Foundation', 'UIKit', 'CoreLocation', 'CoreTelephony'

    s.license             = {
        :type => 'Copyright',
        :text => <<-LICENSE
        Copyright 2013 - 2023 Blesh, Inc. All rights reserved.
        LICENSE
    }
end
