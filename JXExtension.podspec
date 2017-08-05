Pod::Spec.new do |s|

  s.name         = "JXExtension"
  s.version      = "0.2.0"
  s.summary      = "About UIKit Extension."
  s.homepage     = "https://bitbucket.org/JeasonLee/jxextension"
  s.license      = "MIT"
  s.author       = { "Jeason" => "jeason.l@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://JeasonLee@bitbucket.org/JeasonLee/jxextension.git", :tag => "#{s.version}" }
  
  s.public_header_files = 'JXExtension/JXExtension.h'
  s.source_files = 'JXExtension/JXExtension.h'

  s.subspec 'Category' do |category|
    category.source_files = 'JXExtension/Category/*.{h,m}'
  end

  s.subspec 'View' do |view|
    view.source_files = 'JXExtension/View/*.{h,m}'
    view.dependency 'JXExtension/Category'
  end
  
  s.requires_arc = true
  s.dependency 'SDVersion'
  
end
