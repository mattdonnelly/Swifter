Pod::Spec.new do |s|
    s.name                   = 'Swifter'
    s.version                = '2.0.1'
    s.summary                = 'A Twitter framework for iOS & OS X written in Swift '
    s.homepage               = 'https://github.com/mattdonnelly/Swifter'
    s.license                = { :type => "MIT" }
    s.author                 = { 'Andy' => 'andy@meteochu.me' }
    s.social_media_url       = 'https://github.com/mattdonnelly'

    s.requires_arc = true
    s.ios.deployment_target  = '8.0'
    s.source                 = { :git => 'https://github.com/mattdonnelly/Swifter.git', :tag => s.version }
    s.source_files           = 'Swifter/*.swift'
    s.ios.source_files       = 'Swifter/*.swift'
    s.frameworks             = 'UIKit'
    s.pod_target_xcconfig    = { 'SWIFT_VERSION' => '3.0' }
end
