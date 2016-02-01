Pod::Spec.new do |s|
  s.name             = 'AWSPushManager'
  s.version          = '0.0.2'
  s.summary          = 'AWSPushManager, extracted from AWS sample code to use standalone'
  s.homepage         = 'https://github.com/fetch/AWSPushManager'
  s.license          = 'MIT'
  s.author           = { 'Koen Punt' => 'koen@fetch.nl' }
  s.source           = { :git => 'https://github.com/fetch/AWSPushManager.git', :tag => "v#{s.version.to_s}" }

  s.platform     = :ios, '8.0'
  # s.requires_arc = true

  s.dependency 'AWSCore', '~> 2.3.4'
  s.dependency 'AWSSNS', '~> 2.3.4'

  s.source_files = 'AWSPushManager/*'
end
