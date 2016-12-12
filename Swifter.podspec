Pod::Spec.new do |spec|
    spec.name                   = 'Swifter'
    spec.version                = '2.0'
    spec.summary                = 'A Twitter framework for iOS & OS X written in Swift '
    spec.homepage               = 'https://github.com/mattdonnelly/Swifter'
    spec.license                = 'MIT'
    spec.author                 = { 'Andy' => 'andy@meteochu.me' }
    spec.social_media_url       = 'https://github.com/mattdonnelly'
    spec.source                 = { :git => 'https://github.com/mattdonnelly/Swifter.git', :tag => "#{spec.version}" }
    spec.source_files           = 'Swifter/*.swift"'
    spec.platform               = :ios, '10.0'
    spec.requires_arc           = true
    spec.pod_target_xcconfig    = { 'SWIFT_VERSION' => '3.0' }
end
