Pod::Spec.new do |s|
  s.name             = 'TikTokOpenSDK'
  s.version          = '5.0.15'
  s.summary          = 'This SDK may be used to invoke TikTok features.'
  s.description      = 'Includes the following TikTok features: Log in with TikTok, and share videos, photos, and sounds to TikTok.'
  s.homepage         = 'https://developers.tiktok.com/'
  s.license          = { :type => 'Copyright', :text => 'Copyright 2020 bytedance.com. All rights reserved.' }
  s.author           = { 'ByteDance' => 'bytedance.com' }

  # Vendored locally because CocoaPods' trunk spec points at
  # https://sf16-muse-va.ibytedtos.com/..., which returns 403 from CI
  # runner IPs. This is the identical file (md5 d11dc3084ef13de3c364f841492f5620)
  # fetched from TikTok's own docs-linked CDN mirror instead.
  s.source           = { :path => '.' }

  s.platform = :ios, '9.0'
  s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics', 'WebKit', 'Security', 'Photos'
  s.source_files = '**/TikTokOpenSDK.framework/Headers/*.h'
  s.vendored_frameworks = 'TikTokOpenSDK.xcframework'
  s.pod_target_xcconfig = {
    'OTHER_LDFLAGS' => '-ObjC -all_load',
    'OTHER_CFLAGS' => '-fembed-bitcode'
  }
end
