Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '12.0'
s.name = "BeAtHomeFramework"
s.summary = "BeAtHomeFramework lets a user authenticate with Be@Home."
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "DIGITHAI" => "info@digithaigroup.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/digithai/bathome-ios-library"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/digithai/bathome-ios-library.git",
             :tag => "#{s.version}" }


# 8
s.source_files = "BeAtHomeFramework/**/*.{swift}"

# 9
s.resources = "BeAtHomeFramework/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "5.1"

end
