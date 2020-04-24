Pod::Spec.new do |s|

  s.name         = "JXExtension"
  s.version      = "0.4.4"
  s.summary      = "About UIKit Extension."
  s.homepage     = "https://github.com/JeasonL/JXExtension"
  s.license      = "MIT"
  s.author       = { "Jeason" => "jeason.l@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/JeasonL/JXExtension.git", :tag => "#{s.version}" }

  s.public_header_files = 'JXExtension/JXExtension.h'
  s.source_files = 'JXExtension/JXExtension.h'

  s.subspec 'Category' do |ss|
    ss.source_files = 'JXExtension/Category/*.{h,m}'
  end

  s.subspec 'View' do |ss|
    ss.source_files = 'JXExtension/View/*.{h,m}'
    ss.dependency 'JXExtension/Category'
  end

  s.subspec 'Transition' do |ss|
    ss.source_files = 'JXExtension/Transition/*.{h,m}'
  end

  s.dependency 'SDVersion'
  s.requires_arc = true
  s.ios.deployment_target = '7.0'

end
