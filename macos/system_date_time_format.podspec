#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint system_date_time_format.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'system_date_time_format'
  s.version          = '1.4.0'
  s.summary          = 'A plugin for getting date and time format patterns from device system settings.'
  s.description      = <<-DESC
A plugin for getting date and time format patterns from device system settings.
                       DESC
  s.homepage         = 'https://github.com/Nikoro/system_date_time_format'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Dominik Krajcer' => 'https://github.com/Nikoro' }

  s.source           = { :path => '.' }
  s.source_files = 'system_date_time_format/Sources/system_date_time_format/**/*.swift'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.14'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
