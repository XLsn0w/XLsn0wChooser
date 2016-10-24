
Pod::Spec.new do |s|

  s.version      = "1.2.1"
  s.summary      = "XLsn0w Custom A Good Chooser"

  s.license      = "MIT"
  s.requires_arc = true
  s.platform     = :ios, "7.0"
  s.author       = { "XLsn0w" => "xlsn0w@qq.com" }

  s.name         = "XLsn0wChooser"
  s.homepage     = "https://github.com/XLsn0w/XLsn0wChooser"
  s.source       = { :git => "https://github.com/XLsn0w/XLsn0wChooser.git", :tag => s.version }

  s.resources    = "XLsn0w/Resources/XLsn0wChooser.bundle", "XLsn0w/Resources/area.plist"

  s.source_files = "XLsn0w/*.{h,m}", "XLsn0w/XLsn0wChooser/*.{h,m}", "XLsn0w/XLsn0wTimeChooser/*.{h,m}", "XLsn0w/XLsn0wAlertChooser/*.{h,m}", "XLsn0w/XLsn0wChooserMenu/*.{h,m}", "XLsn0w/XLsn0wActionSheet/*.{h,m}", "XLsn0w/XLsn0wCenterDater/*.{h,m}", "XLsn0w/XLsn0wCenterDatePicker/*.{h,m}", "XLsn0w/XLsn0wPickerSingler/*.{h,m}", "XLsn0w/XLsn0wPickerAreaer/*.{h,m}", "XLsn0w/XLsn0wPickerDater/*.{h,m}", "XLsn0w/XLsn0wPopMenu/*.{h,m}", "XLsn0w/XLsn0wDropMenu/*.{h,m}", "XLsn0w/XLsn0wToolbar/*.{h,m}", "XLsn0w/UMSocialShareView/*.{h,m}", "XLsn0w/XLsn0wImageSelector/*.{h,m}", "XLsn0w/XLsn0wImageSelector/XLsn0wImageSelectorTableViewCell/*.{h,m}", "XLsn0w/XLsn0wGuidePager/*.{h,m}"

  s.dependency 'Masonry'
  s.dependency 'SDWebImage'
  s.dependency 'UMengSocialCOM', '~> 5.1.0'

end
