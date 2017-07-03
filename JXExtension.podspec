Pod::Spec.new do |s|

  s.name         = "JXExtension"
  s.version      = "0.1.1"
  s.summary      = "About UIKit Extension."
  s.homepage     = "https://bitbucket.org/JeasonLee/jxextension"
  s.license      = "MIT"
  s.author       = { "Jeason" => "jeason.l@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://JeasonLee@bitbucket.org/JeasonLee/jxextension.git", :tag => "#{s.version}" }
  s.source_files = "JXExtension/JXExtension/**/*.{h,m}"
  s.requires_arc = true
  
end
