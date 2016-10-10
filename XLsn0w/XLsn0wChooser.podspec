
Pod::Spec.new do |s|

  s.version      = "1.0.7"
  s.summary      = "XLsn0w Custom A good Chooser"

  s.license      = "MIT"
  s.requires_arc = true
  s.platform     = :ios, "7.0"
  s.author       = { "XLsn0w" => "xlsn0w@qq.com" }

  s.name         = "XLsn0wChooser"
  s.homepage     = "https://github.com/XLsn0w/XLsn0wChooser"
  s.source       = { :git => "https://github.com/XLsn0w/XLsn0wChooser.git", :tag => s.version }

  s.source_files = "XLsn0w/*.{h,m}", "XLsn0w/XLsn0wChooser/*.{h,m}","XLsn0w/XLsn0wPopMenu/*.{h,m}","XLsn0w/XLsn0wDatePicker/*.{h,m}","XLsn0w/XLsn0wDropMenu/*.{h,m}"

  s.resources    = "XLsn0w/XLsn0wChooser/SGDatePickerCenterView.xib","XLsn0w/XLsn0wChooser/SGDatePickerSheetView.xib","XLsn0w/XLsn0wChooser/SGLocationPickerCenterView.xib","XLsn0w/XLsn0wChooser/SGLocationPickerSheetView.xib"

  s.dependency 'Masonry'

end
