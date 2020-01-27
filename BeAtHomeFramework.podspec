Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '10.0'
s.name = "BeAtHomeFramework"
s.summary = "BeAtHomeFramework lets a user authenticate with Be@Home."
s.requires_arc = true

s.version = "1.0.4"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "DIGITHAI" => "info@digithaigroup.com" }

s.homepage = "https://github.com/digithai/bathome-ios-library"

s.source = { :git => "https://github.com/digithai/src-bathome-ios-library.git",
             :tag => "#{s.version}" }

s.public_header_files = "BeAtHomeFramework.framework/Headers/*.h"
s.source_files = "BeAtHomeFramework.framework/Headers/*.h"
s.vendored_frameworks = "BeAtHomeFramework.framework"

s.swift_version = "4.0"

end
