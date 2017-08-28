Pod::Spec.new do |s|

  s.name         = "JXExtension"
  s.version      = "0.2.9"
  s.summary      = "About UIKit Extension."
  s.homepage     = "https://gitlab.com/JeasonLee/JXExtension"
  s.license      = "MIT"
  s.author       = { "Jeason" => "jeason.l@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://JeasonLee@gitlab.com/JeasonLee/JXExtension.git", :tag => "#{s.version}" }

  s.public_header_files = 'JXExtension/JXExtension.h'
  s.source_files = 'JXExtension/JXExtension.h'

  s.subspec 'Category' do |category|
    category.source_files = 'JXExtension/Category/*.{h,m}'
    category.requires_arc = true
  end

  s.subspec 'View' do |view|
    view.source_files = 'JXExtension/View/*.{h,m}'
    view.dependency 'JXExtension/Category'
    view.requires_arc = true
  end

  s.dependency 'SDVersion'
  s.requires_arc = true

end
