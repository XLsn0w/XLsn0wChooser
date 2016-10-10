
Pod::Spec.new do |s|

  s.version      = "1.0.1"
  s.summary      = "XLsn0w Custom A good Chooser"

  s.license      = "MIT"
  s.requires_arc = true
  s.platform     = :ios, "7.0"
  s.author       = { "XLsn0w" => "xlsn0w@qq.com" }

  s.name         = "XLsn0wChooser"
  s.homepage     = "https://github.com/XLsn0w/XLsn0wChooser"
  s.source       = { :git => "https://github.com/XLsn0w/XLsn0wChooser.git", :tag => s.version }

  s.source_files = "XLsn0w/*.{h,m,xib}"
#s.resources    = "XLsn0w/XLsn0wLoop/XLsn0wLoop.png"

end
