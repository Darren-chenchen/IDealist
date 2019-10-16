Pod::Spec.new do |s|
  s.name = 'IDealist'
  s.version = '0.0.8'
  s.swift_version = '4.2'
  s.license = 'MIT'
  s.summary = 'This is a IOS Components'
  s.homepage = 'https://github.com/Darren-chenchen/IDealist.git'
  s.authors = { 'chenliang' => '1597887620@qq.com' }
  s.source = { :git => 'https://github.com/Darren-chenchen/IDealist.git', :tag => s.version.to_s }

  s.public_header_files = 'IDealist/IDealist/IDScanCode/**/*.h'

  s.requires_arc = true

  s.ios.deployment_target = '8.0'

  s.source_files = ['IDealist/IDealist/**/*.swift', 'IDealist/IDealist/IDScanCode/Components/*.{h,m}']

  s.resource_bundles = { 
	'IDealist' => ['IDealist/IDealist/IDUIKit/Images/**/*.png',
  'IDealist/IDealist/IDToast/Images/**/*.png',
  'IDealist/IDealist/IDDialog/Images/**/*.png',
  'IDealist/IDealist/IDScanCode/Images/**/*.png',
  'IDealist/IDealist/IDLoading/Images/**/*.png',
  'IDealist/IDealist/IDImagePicker/Images/**/*.png',
  'IDealist/IDealist/IDEmptyView/Images/**/*.png',
  'IDealist/IDealist/IDBaseController/Images/**/*.png',
  'IDealist/IDealist/IDScanCode/**/*.{xib}',
  'IDealist/IDealist/IDImagePicker/**/*.{xib,storyboard}',
  'IDealist/IDealist/IDImagePicker/**/*.{lproj,strings}']
  }

  s.dependency 'JXSegmentedView', '0.0.4'

end
