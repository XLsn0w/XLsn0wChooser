
Pod::Spec.new do |s|

  s.version      = "1.1.3"
  s.summary      = "XLsn0w Custom A good Chooser"

  s.license      = "MIT"
  s.requires_arc = true
  s.platform     = :ios, "7.0"
  s.author       = { "XLsn0w" => "xlsn0w@qq.com" }

  s.name         = "XLsn0wChooser"
  s.homepage     = "https://github.com/XLsn0w/XLsn0wChooser"
  s.source       = { :git => "https://github.com/XLsn0w/XLsn0wChooser.git", :tag => s.version }

  s.source_files = "XLsn0w/*.{h,m}", "XLsn0w/XLsn0wPopMenu/*.{h,m}", "XLsn0w/XLsn0wDatePicker/*.{h,m}", "XLsn0w/XLsn0wDropMenu/*.{h,m}", "XLsn0w/XLsn0wToolbar/*.{h,m}", "XLsn0w/XLsn0wPickerAreaer/*.{h,m}", "XLsn0w/XLsn0wPickerSingler/*.{h,m}", "XLsn0w/XLsn0wPickerDater/*.{h,m}", "XLsn0w/XLsn0wCenterDatePicker/*.{h,m}", 

  s.resources    = "XLsn0w/Resources/area.plist", "XLsn0w/XLsn0wCenterDatePicker/XLsn0wCenterDatePicker.xib"

  s.dependency 'Masonry'

end
