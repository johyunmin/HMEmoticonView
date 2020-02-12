#
# Be sure to run `pod lib lint HMEmoticonView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HMEmoticonView'
  s.version          = '1.0.1'
  s.summary          = 'HMEmoticonView.'
  s.description      = 'Keyboard KeyWindow View'

  s.homepage         = 'https://github.com/johyunmin/HMEmoticonView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'johyunmin' => 'gusalswh@naver.com' }
  s.source           = { :git => 'https://github.com/johyunmin/HMEmoticonView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
  s.resource_bundles = {
    'HMEmoticonView' => ['**/*.xib']
  }
  s.source_files = '*.swift'
  s.resources    = ["**/*.xcassets", "**/HMEmoticonCollectionViewCell.xib"]
  s.frameworks   = 'UIKit', 'AVFoundation'
#
#      full.dependency 'BMPlayer/Core'
#      full.dependency 'SnapKit', '~> 5.0.0'
#      full.dependency 'NVActivityIndicatorView', '~> 4.7.0'
#
#  s.source_files = '*.swift'
#
#   s.resource_bundles = {
#     'HMEmoticonView' => ['HMAssets/*.png','*.xib']
#   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
